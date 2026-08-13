"""mitmproxy アドオン: Turbo Intruder を subprocess で呼び出してレースを撃つ.

対象フローのリクエストを Turbo Intruder (PortSwigger の Burp 拡張だが単体 jar
として headless 実行できる) に渡し, race condition 攻撃を撃つ. レースのシビアな
タイミング制御は jar 側のテスト済みエンジンに任せ, このアドオンは
「フローを取り出す -> raw リクエストに組み立てる -> jar に渡す -> 結果をログに出す」
という接着剤に徹する.

turbo.menu (space t) は 3 種を 1 メニューにまとめた統合レースメニュー:
	- last-byte sync (native)   race_lastbyte.py の raw ソケット実装をレジストリ
	                            経由 (race.lastbyte) で呼ぶ. multi-endpoint 対応.
	- last-byte sync (turbo)    Turbo Intruder の Engine.THREADED (HTTP/1.1).
	- single-packet (HTTP/2)    Turbo Intruder の Engine.HTTP2. 1 パケットに全
	                            リクエストを載せて撃つ HTTP/2 レースの本命.
	native は raw ソケットで ALPN を http/1.1 に固定するため single-packet は撃てない.
	そこを Turbo Intruder が補完する, という住み分け. Turbo Intruder は 1 リクエスト
	テンプレートしか撃てないので, turbo 系は単一フロー時のみメニューに出す.

前提 (環境変数で差し替え可):
	TURBO_INTRUDER_JAR     turbo-intruder-all.jar のパス
	                       既定: ~/.mitmproxy/turbo-intruder-all.jar
	TURBO_INTRUDER_SCRIPT  headless 用スクリプト (queueRequests/handleResponse)
	                       既定: script/libexec/turbo_attack.py
	TURBO_INTRUDER_JAVA    java 実行ファイル. 既定: java (PATH から探す)

jar のビルド:
	git clone https://github.com/PortSwigger/turbo-intruder
	cd turbo-intruder && ./gradlew build fatjar
	build/libs/turbo-intruder-all.jar を上記パスに置く (Jython 同梱の fat jar).

使い方 (TUI コマンド欄 or leader メニュー space t):
	:turbo.menu                        # 統合レースメニュー (native/turbo/single-packet) を開く
	:turbo.race @focus                 # focus を既定 (HTTP2, 20 本) で
	:turbo.race @focus 30              # 30 本で
	:turbo.race @focus 30 THREADED     # last-byte sync (threaded) 30 本で

結果は mitmproxy のイベントログ (コンソールで E) に出る. jar 実行は数秒かかるが
ワーカースレッドに逃がすので UI は固まらない. エンジン/本数は環境変数
TURBO_ENGINE / TURBO_REQUESTS 経由で headless スクリプトに渡す (argv の
wordlist 規約と衝突しないため).
"""

from __future__ import annotations

import asyncio
import logging
import os
import shutil
import subprocess
import tempfile
import threading
from collections.abc import Sequence
from pathlib import Path

from mitmproxy import command
from mitmproxy import ctx
from mitmproxy import exceptions
from mitmproxy import flow
from mitmproxy import http
from mitmproxy.log import ALERT
from mitmproxy.net.http.http1 import assemble

logger = logging.getLogger(__name__)

TIMEOUT = 120.0  # jar 実行のタイムアウト (秒). レース本体は速いが JVM 起動が重い

DEFAULT_JAR = Path.home() / '.mitmproxy' / 'turbo-intruder-all.jar'
# turbo_attack.py は mitmproxy の addon ではなく jar が実行する補助スクリプト.
# config.yaml は個別ファイルを列挙するので, script/ 直下の addon とは別に
# script/libexec/ へ置いても addon としてはロードされない.
DEFAULT_SCRIPT = Path(__file__).resolve().parent / 'libexec' / 'turbo_attack.py'
DEFAULT_JAVA = 'java'

# turbo.race が受け付けるエンジン.
# HTTP2 = single-packet attack (HTTP/2 レースの本命). THREADED = last-byte sync
# 相当 (HTTP/1.1). BURP2 は Burp 本体が要るので headless では使えない.
ENGINES: list[tuple[str, str]] = [
	('single-packet (HTTP/2)', 'HTTP2'),
	('last-byte sync (threaded)', 'THREADED'),
]

# 統合レースメニュー (space t) に出す本数候補. native / turbo-lbs / single-packet
# の 3 種で共通に使う (単一フロー時). native の複数フロー時のみ 1 (各エンドポイント
# 1 本ずつの multi-endpoint) を頭に足す.
RACE_COUNTS: list[int] = [10, 20, 30, 50, 100]

DEFAULT_ENGINE = 'HTTP2'
DEFAULT_COUNT = 20


def _jar_path() -> Path:
	return Path(os.environ.get('TURBO_INTRUDER_JAR', str(DEFAULT_JAR))).expanduser()


def _script_path() -> Path:
	return Path(os.environ.get('TURBO_INTRUDER_SCRIPT', str(DEFAULT_SCRIPT))).expanduser()


def _java_bin() -> str:
	return os.environ.get('TURBO_INTRUDER_JAVA', DEFAULT_JAVA)


class TurboRace:
	def __init__(self) -> None:
		self.loop: asyncio.AbstractEventLoop | None = None
		# メニューを開いた時点の対象フローと, ラベル -> (kind, count) の対応.
		# kind は 'native' / 'turbo-lbs' / 'turbo-sp'. チューザーは overlay なので,
		# 開いた後に focus/mark が変わっても影響しないよう保持する
		# (race_lastbyte.py と同じ考え方).
		self._targets: list[flow.Flow] = []
		self._menu_actions: dict[str, tuple[str, int]] = {}

	def running(self) -> None:
		# ワーカースレッドから結果を UI スレッドへ戻すためのループ参照を保持
		self.loop = asyncio.get_running_loop()

	# --- 対象フローの解決 ---------------------------------------------------

	def _resolve_targets(self) -> list[flow.Flow]:
		"""レース対象を決める. mark されたフローがあればそれ, 無ければ focus.

		race_lastbyte.py の同名メソッドと同型 (mitmproxy はスクリプトを別モジュール
		でロードするため import 共有はせず, 同じ小ロジックを持つ).
		"""
		view = ctx.master.view
		marked = [f for f in view if getattr(f, 'marked', '')]
		if marked:
			return marked
		focused = view.focus.flow
		return [focused] if focused is not None else []

	# --- 統合レースメニュー (space t) --------------------------------------
	# native (race_lastbyte.py) の last-byte sync と, Turbo Intruder の
	# last-byte sync / single-packet attack を 1 メニューにまとめる. native は
	# コマンドレジストリ経由 (race.lastbyte) で呼ぶので, この addon 単体でも
	# turbo 分だけは動く.

	@command.command('turbo.menu')
	def menu(self) -> None:
		"""レース対象に対する native / turbo / single-packet の選択メニューを開く.

		jar が無くても native は撃てるので, ここでは preflight しない
		(jar チェックは turbo 系を選んだときに turbo.race 内で行う).
		"""
		targets = self._resolve_targets()
		if not targets:
			raise exceptions.CommandError('No flow to race (focus a flow or mark some).')
		for f in targets:
			if not isinstance(f, http.HTTPFlow) or not f.request:
				raise exceptions.CommandError("Can't race a flow with no request.")

		self._targets = targets
		n = len(targets)
		self._menu_actions = {}

		# native last-byte sync (race_lastbyte.py). multi-endpoint (複数フロー) 対応.
		# 複数フロー時のみ k=1 (各エンドポイント 1 本ずつ) を候補に足す.
		if 'race.lastbyte' in ctx.master.commands.commands:
			counts = RACE_COUNTS if n == 1 else [1, *RACE_COUNTS]
			for k in counts:
				if n == 1 and k < 2:
					continue  # 単一フローを 1 本ではレースにならない
				total = n * k
				if n == 1:
					label = f'last-byte sync (native) x{k}  ({total} conns)'
				else:
					label = f'last-byte sync (native) x{k}  ({n} flows x {k} = {total} conns)'
				self._menu_actions[label] = ('native', k)

		# Turbo Intruder は 1 リクエストテンプレートしか撃てないので単一フロー時のみ.
		if n == 1:
			for k in RACE_COUNTS:
				self._menu_actions[f'last-byte sync (turbo) x{k}'] = ('turbo-lbs', k)
			for k in RACE_COUNTS:
				self._menu_actions[f'single-packet (HTTP/2) x{k}'] = ('turbo-sp', k)

		ctx.master.commands.call(
			'console.choose.cmd',
			'Race attack',  # プロンプト
			'turbo.actions',  # 選択肢を返すコマンド
			'turbo.run',  # 選択後に呼ぶコマンド
			'{choice}',  # 選んだラベルに置換される
		)

	@command.command('turbo.actions')
	def actions(self) -> Sequence[str]:
		"""選択メニューに出す項目一覧 (menu を開いた時点で確定済み)."""
		return list(self._menu_actions.keys())

	@command.command('turbo.run')
	def run(self, action: str) -> None:
		"""メニューで選ばれたラベルに対応する実装/本数でレースを実行する."""
		chosen = self._menu_actions.get(action)
		if chosen is None:
			raise exceptions.CommandError(f'Unknown race action: {action}')
		if not self._targets:
			raise exceptions.CommandError('No target flow (reopen the menu).')
		kind, k = chosen
		if kind == 'native':
			# 別 addon (race_lastbyte.py) の native 実行をレジストリ経由で呼ぶ.
			# native call 経路なので flows(list)/int を素通しで渡せる.
			ctx.master.commands.call('race.lastbyte', self._targets, k)
		elif kind == 'turbo-lbs':
			self.race([self._targets[0]], k, 'THREADED')
		else:  # 'turbo-sp'
			self.race([self._targets[0]], k, 'HTTP2')

	# --- 実行本体 -----------------------------------------------------------

	@command.command('turbo.race')
	def race(self, flows: Sequence[flow.Flow], count: int = DEFAULT_COUNT, engine: str = DEFAULT_ENGINE) -> None:
		"""flows の先頭リクエストを Turbo Intruder に渡し count 本のレースを撃つ.

		Turbo Intruder は 1 テンプレートを撃つので, 複数渡されても先頭のみ使う.
		"""
		if not flows:
			raise exceptions.CommandError('No flow to race.')
		if count < 1:
			raise exceptions.CommandError('count must be >= 1.')
		engine = engine.upper()
		valid = {e for _, e in ENGINES}
		if engine not in valid:
			raise exceptions.CommandError(f'Unknown engine {engine!r} (use one of {sorted(valid)}).')

		f = flows[0]
		if not isinstance(f, http.HTTPFlow) or not f.request:
			raise exceptions.CommandError("Can't race a flow with no request.")

		self._preflight()

		# race_lastbyte と同じ手順で on-the-wire なバイト列を組み立てる
		# (content-encoding を解除し, content-length を実ボディに合わせる).
		# 手組みでヘッダ行を join するより取りこぼしが無い.
		req = f.request.copy()
		req.decode(strict=False)
		try:
			raw = assemble.assemble_request(req)
		except ValueError as e:
			raise exceptions.CommandError(str(e))

		endpoint = f'{req.scheme}://{req.host}:{req.port}'
		label = f'{req.method} {req.pretty_url}'
		logger.info(f'[turbo] {engine} x{count} start: {label}')

		# JVM 起動 + jar 実行は数秒かかるので UI ループを止めないよう
		# ワーカースレッドに逃がす (race_lastbyte と同じ方針).
		threading.Thread(
			target=self._run,
			args=(raw, endpoint, label, engine, count),
			name='turbo.race',
			daemon=True,
		).start()

	def _preflight(self) -> None:
		"""jar / headless スクリプトの存在を実行前に確認し, 無ければ即エラーにする.

		java の不在は subprocess 実行時 (ワーカースレッド) に判明するのでそこで
		ログに出す. jar/スクリプトはパスの取り違えが多いので同期的に弾く.
		"""
		jar = _jar_path()
		if not jar.is_file():
			raise exceptions.CommandError(
				f'turbo-intruder jar not found: {jar}\n'
				'Set $TURBO_INTRUDER_JAR, or build it:\n'
				'  git clone https://github.com/PortSwigger/turbo-intruder\n'
				'  cd turbo-intruder && ./gradlew build fatjar\n'
				'  cp build/libs/turbo-intruder-all.jar ~/.mitmproxy/'
			)
		script = _script_path()
		if not script.is_file():
			raise exceptions.CommandError(
				f'turbo attack script not found: {script}\nSet $TURBO_INTRUDER_SCRIPT.'
			)

	def _run(self, raw: bytes, endpoint: str, label: str, engine: str, count: int) -> None:
		# リクエストテンプレートと, wordlist 引数用のダミーファイルを作る.
		# Turbo Intruder の headless CLI は第 4 引数に「入力」を要求するが,
		# レースでは注入点を使わないのでダミーで足りる. ファイルパスとして渡すと
		# 実装差 (リテラル扱い / ファイル扱い) のどちらでも壊れにくい.
		tmpdir = tempfile.mkdtemp(prefix='turbo_')
		reqfile = Path(tmpdir) / 'request.txt'
		wordfile = Path(tmpdir) / 'wordlist.txt'
		result: str
		try:
			reqfile.write_bytes(raw)
			wordfile.write_text('race\n')

			env = dict(os.environ)
			# headless スクリプトへエンジンと本数を渡す (argv を汚さない経路).
			env['TURBO_ENGINE'] = engine
			env['TURBO_REQUESTS'] = str(count)

			cmd = [
				_java_bin(),
				'-jar',
				str(_jar_path()),
				str(_script_path()),
				str(reqfile),
				endpoint,
				str(wordfile),
			]
			try:
				proc = subprocess.run(
					cmd,
					capture_output=True,
					text=True,
					timeout=TIMEOUT,
					env=env,
				)
			except FileNotFoundError:
				result = (
					f'[turbo] java not found: {_java_bin()!r}. '
					'Install a JRE or set $TURBO_INTRUDER_JAVA.'
				)
				self._post(lambda: logger.log(ALERT, result))
				return
			except subprocess.TimeoutExpired:
				result = f'[turbo] timed out after {TIMEOUT:.0f}s: {label}'
				self._post(lambda: logger.log(ALERT, result))
				return

			out = (proc.stdout or '').strip()
			err = (proc.stderr or '').strip()

			def report() -> None:
				logger.info(f'[turbo] {engine} x{count} done: {label} (exit {proc.returncode})')
				if out:
					logger.info('[turbo] stdout:\n' + out)
				if err:
					# Turbo Intruder は進捗を stderr に出すことがあるので warning 止まり
					logger.log(ALERT, '[turbo] stderr:\n' + err)
				if not out and not err:
					logger.info('[turbo] (no output)')

			self._post(report)
		except Exception as e:  # noqa: BLE001 - 想定外も UI を落とさずログに出す
			self._post(lambda: logger.log(ALERT, f'[turbo] failed: {e}'))
		finally:
			shutil.rmtree(tmpdir, ignore_errors=True)

	def _post(self, fn) -> None:
		"""ワーカースレッドから UI ループスレッドへログ出力を戻す."""
		if self.loop is not None:
			self.loop.call_soon_threadsafe(fn)
		else:
			fn()


addons = [TurboRace()]
