"""mitmproxy アドオン: last-byte synchronization レースコンディション送信.

対象の HTTP リクエスト群を, 各コネクションで最終 1 バイトだけ保留し,
threading.Barrier で足並みを揃えてから一斉に送出する. mitmproxy 本体の
プロキシ/リプレイ経路は使わず, アドオン内で独自に raw ソケットを開くため,
last-byte sync に必要なバイト単位の送出制御ができる.

対象は「フロー群 × 複製数 K」で決まる. フローを 1 つ (@focus) にすれば従来
どおり同一リクエストの K 本レース. 複数フローを mark して渡せば, 異なる
リクエストを同時に衝突させる multi-endpoint レースになる. 総コネクション数は
(フロー数 x K) で, 全コネクションを 1 つの barrier で同期する.

    K=1  かつ 複数フロー  # 各エンドポイントを 1 本ずつ, 同時衝突
    K=20 かつ 単一フロー  # 同一リクエストを 20 本, 同時送出
    K=10 かつ 複数フロー  # 各エンドポイントを 10 本ずつ (multi-endpoint + 物量)

レスポンスの確認:
	raw ソケットで送るのでこれらのリクエストは通常フローリストに出ない.
	そこで送信後, レスポンス全文を取り込めた全コネクション分を 1 本ずつパースして
	http.HTTPFlow として mitmproxy に注入する (master.load_flow). これによりフロー
	リストに並び, flowview や既存のコピー系ツール (space r 等) がそのまま使える.
	x100 なら (レスポンスを取り込めた分だけ) 最大 100 本増える. 大量に注入すると
	フローリストが埋まるので, 件数を絞りたい場合は count を減らす. イベントログ
	(E) には代表ではなくステータスライン分布 (集計) を出す.

使い方 (TUI コマンド欄 or キーバインド):
	:race.menu                     # 選択メニューを開く (marked があれば marked, 無ければ focus)
	:race.lastbyte @focus          # focus を K=20 (デフォルト) で
	:race.lastbyte @focus 30       # focus を K=30 で
	:race.lastbyte @marked 10      # marked 各フローを K=10 ずつ同時送出
	:race.lastbyte @marked 1       # marked 各フローを 1 本ずつ (multi-endpoint)

mitmproxy はキャプチャ・トリガ・UI・リクエスト組み立てを担当し, 実際の
送信だけをこのアドオンが行う, という役割分担.
"""

from __future__ import annotations

import asyncio
import logging
import socket
import ssl
import threading
import time
from collections import Counter
from collections.abc import Sequence
from typing import NamedTuple

from mitmproxy import command
from mitmproxy import connection
from mitmproxy import ctx
from mitmproxy import exceptions
from mitmproxy import flow
from mitmproxy import http
from mitmproxy.net.http.http1 import assemble
from mitmproxy.net.http.http1.read import expected_http_body_size
from mitmproxy.net.http.http1.read import read_response_head

logger = logging.getLogger(__name__)

TIMEOUT = 10.0
RECV_CAP = 65536  # 1 回の recv で読む最大バイト
HEAD_CAP = 65536  # レスポンスヘッダ部の許容最大バイト (超えたら打ち切り)
BODY_CAP = 262144  # 取り込むボディの最大バイト (メモリ保護のための上限)

# メニューに出す複製数 K の候補 (フロー 1 つあたりのコネクション数).
# 単一フローのときは K=1 だとレースにならない (1 コネクション) ので出さない.
RACE_COPIES: list[int] = [1, 10, 20, 50, 100]


class Job(NamedTuple):
	"""1 コネクションが送る内容. 同一フロー由来の複製は同じ Job を共有する."""

	host: str
	port: int
	use_tls: bool
	head: bytes  # 最終バイトを除いた先送り分
	last: bytes  # レースの引き金となる最終 1 バイト
	label: str  # レポート/注入表示用 (method + url)
	request: http.Request  # 注入するフローの request, ボディサイズ判定にも使う


class Result(NamedTuple):
	"""1 コネクションの結果. フロー注入とレポートの材料."""

	label: str
	status: str  # ステータスライン, または CONNECT_ERR 等のマーカー
	request: http.Request
	raw: bytes | None  # レスポンス全文 (取り込めたとき). エラー時は None


class RaceLastByte:
	def __init__(self) -> None:
		self.loop: asyncio.AbstractEventLoop | None = None
		# メニューを開いた時点の対象フローと, ラベル -> K の対応. チューザーは
		# overlay なので, 開いた後に focus/mark が変わっても影響しないよう保持する.
		self._targets: list[flow.Flow] = []
		self._menu_actions: dict[str, int] = {}

	def running(self) -> None:
		# ワーカースレッドから結果を UI スレッドへ戻すためのループ参照を保持
		self.loop = asyncio.get_running_loop()

	# --- 対象フローの解決 ---------------------------------------------------

	def _resolve_targets(self) -> list[flow.Flow]:
		"""レース対象を決める. mark されたフローがあればそれ, 無ければ focus."""
		view = ctx.master.view
		marked = [f for f in view if getattr(f, 'marked', '')]
		if marked:
			return marked
		focused = view.focus.flow
		return [focused] if focused is not None else []

	# --- 自前の選択メニュー -------------------------------------------------
	# キーバインドを消費せず, コマンドバーから :race.menu で開ける.
	# console.choose.cmd がチューザーのオーバーレイを出し, 選んだラベルで
	# {choice} を置換して race.run を呼ぶ. call_strings が引数配列で渡すため,
	# ラベルにスペースや括弧が入っていても 1 引数として安全に届く.

	@command.command('race.menu')
	def menu(self) -> None:
		"""レース対象 (marked or focus) に対する選択メニューを開く."""
		targets = self._resolve_targets()
		if not targets:
			raise exceptions.CommandError('No flow to race (focus a flow or mark some).')
		for f in targets:
			if not isinstance(f, http.HTTPFlow) or not f.request:
				raise exceptions.CommandError("Can't race a flow with no request.")

		self._targets = targets
		n = len(targets)
		# 対象数に応じてラベルを組み立てる (総コネクション数まで見せる).
		self._menu_actions = {}
		for k in RACE_COPIES:
			if n == 1 and k < 2:
				continue  # 単一フローを 1 本ではレースにならない
			total = n * k
			if n == 1:
				label = f'last-byte sync x{k}  ({total} conns)'
			else:
				label = f'last-byte sync x{k}  ({n} flows x {k} = {total} conns)'
			self._menu_actions[label] = k

		ctx.master.commands.call(
			'console.choose.cmd',
			'Race attack',  # プロンプト
			'race.actions',  # 選択肢を返すコマンド
			'race.run',  # 選択後に呼ぶコマンド
			'{choice}',  # 選んだラベルに置換される
		)

	@command.command('race.actions')
	def actions(self) -> Sequence[str]:
		"""選択メニューに出す項目一覧 (menu を開いた時点の対象数で確定済み)."""
		return list(self._menu_actions.keys())

	@command.command('race.run')
	def run(self, action: str) -> None:
		"""メニューで選ばれたラベルに対応する K でレースを実行する."""
		k = self._menu_actions.get(action)
		if k is None:
			raise exceptions.CommandError(f'Unknown race action: {action}')
		self.lastbyte(self._targets, k)

	# --- 実行本体 -----------------------------------------------------------

	@command.command('race.lastbyte')
	def lastbyte(self, flows: Sequence[flow.Flow], count: int = 20) -> None:
		"""flows の各リクエストを count 本ずつ, 全体を last-byte sync で同時送出する.

		総コネクション数は len(flows) * count. これが 2 未満だとレースにならない
		(単一フロー + count=1 など) ので弾く.
		"""
		if not flows:
			raise exceptions.CommandError('No flow to race.')
		if count < 1:
			raise exceptions.CommandError('count must be >= 1.')

		jobs: list[Job] = []
		for f in flows:
			if not isinstance(f, http.HTTPFlow) or not f.request:
				raise exceptions.CommandError("Can't race a flow with no request.")
			# raw エクスポートと同じ手順で生バイト列を組み立てる
			# (content-encoding を解除し, content-length を実ボディに合わせる)
			req = f.request.copy()
			req.decode(strict=False)
			try:
				raw = assemble.assemble_request(req)
			except ValueError as e:
				raise exceptions.CommandError(str(e))
			if len(raw) < 2:
				raise exceptions.CommandError('Request too short for last-byte sync.')
			jobs.append(
				Job(
					host=req.host,
					port=req.port,
					use_tls=req.scheme == 'https',
					head=raw[:-1],
					last=raw[-1:],
					label=f'{req.method} {req.pretty_url}',
					request=req,
				)
			)

		# 各フローを count 本に複製し, 1 コネクション = 1 Job に展開する.
		expanded = [job for job in jobs for _ in range(count)]
		total = len(expanded)
		if total < 2:
			raise exceptions.CommandError(
				'Need at least 2 connections for a race (increase count or mark more flows).'
			)

		logger.info(f'[race] last-byte sync start: {len(jobs)} flow(s) x {count} = {total} conns')

		# asyncio ループを止めないよう, 送信一式はワーカースレッドへ逃がす
		threading.Thread(
			target=self._run,
			args=(expanded,),
			name='race.lastbyte',
			daemon=True,
		).start()

	def _run(self, jobs: list[Job]) -> None:
		total = len(jobs)
		barrier = threading.Barrier(total)
		results: list = [None] * total
		threads = [
			threading.Thread(
				target=self._worker,
				args=(i, jobs[i], barrier, results),
				daemon=True,
			)
			for i in range(total)
		]
		for t in threads:
			t.start()
		for t in threads:
			t.join()
		# 集計ログとフロー注入は UI と同じループスレッドに戻して行う
		# (view/master への追加はメインスレッドで行う必要があるため)
		if self.loop is not None:
			self.loop.call_soon_threadsafe(self._finish, results)

	@staticmethod
	def _worker(
		idx: int,
		job: Job,
		barrier: threading.Barrier,
		results: list,
	) -> None:
		try:
			sock: socket.socket = socket.create_connection((job.host, job.port), timeout=TIMEOUT)
			if job.use_tls:
				ssl_ctx = ssl.create_default_context()
				ssl_ctx.check_hostname = False
				ssl_ctx.verify_mode = ssl.CERT_NONE
				ssl_ctx.set_alpn_protocols(['http/1.1'])
				sock = ssl_ctx.wrap_socket(sock, server_hostname=job.host)
			sock.setsockopt(socket.IPPROTO_TCP, socket.TCP_NODELAY, 1)
			# 最終バイト以外を先送りし, サーバを受信待ちにさせる
			sock.sendall(job.head)
		except Exception as e:  # noqa: BLE001 - 接続段階のエラーはそのまま報告
			results[idx] = Result(job.label, f'CONNECT_ERR: {e}', job.request, None)
			barrier.abort()  # 揃わないと分かった時点で全員を解放
			return

		try:
			barrier.wait()  # 全スレッドがここで揃う
		except threading.BrokenBarrierError:
			results[idx] = Result(job.label, 'BARRIER_BROKEN', job.request, None)
			sock.close()
			return

		try:
			sock.sendall(job.last)  # レースの引き金: 最終バイトを一斉送出
			raw = RaceLastByte._recv_response(sock, job.request)
			line = raw.split(b'\r\n', 1)[0].decode(errors='replace') if raw else ''
			results[idx] = Result(job.label, line or 'EMPTY', job.request, raw)
		except Exception as e:  # noqa: BLE001
			results[idx] = Result(job.label, f'SEND_ERR: {e}', job.request, None)
		finally:
			sock.close()

	@staticmethod
	def _recv_response(sock: socket.socket, request: http.Request) -> bytes | None:
		"""レスポンス全文を取り込む. content-length / chunked / EOF を見て終端する.

		keep-alive で content-length ぶん読み終えても close されないケースがあるので,
		ヘッダから期待ボディサイズを求めて必要分だけ読む. 途中の timeout は「そこまで」
		として静かに打ち切る (例外にしない). BODY_CAP でメモリ上限も設ける.
		"""
		sock.settimeout(TIMEOUT)

		def recv() -> bytes:
			try:
				return sock.recv(RECV_CAP)
			except socket.timeout:
				return b''

		# ヘッダ終端まで読む
		buf = b''
		while b'\r\n\r\n' not in buf:
			chunk = sock.recv(RECV_CAP)  # ヘッダが来ない timeout は SEND_ERR 扱いでよい
			if not chunk:
				return buf or None
			buf += chunk
			if len(buf) > HEAD_CAP:
				return buf  # ヘッダが異常に長い: 打ち切り
		head, _, body = buf.partition(b'\r\n\r\n')

		try:
			resp = read_response_head(head.split(b'\r\n'))
			size = expected_http_body_size(request, resp)
		except Exception:  # noqa: BLE001 - パース不可でも読めた分は返す
			return buf

		if size is None:  # chunked: 終端チャンクまで (簡易判定)
			while b'0\r\n\r\n' not in body and len(body) < BODY_CAP:
				chunk = recv()
				if not chunk:
					break
				body += chunk
		elif size < 0:  # EOF まで
			while len(body) < BODY_CAP:
				chunk = recv()
				if not chunk:
					break
				body += chunk
		else:  # content-length ぶんだけ
			while len(body) < size and len(body) < BODY_CAP:
				chunk = recv()
				if not chunk:
					break
				body += chunk
			body = body[:size]

		return head + b'\r\n\r\n' + body

	# --- 集計 + フロー注入 ---------------------------------------------------

	def _finish(self, results: list) -> None:
		self._report(results)
		self._inject(results)

	def _report(self, results: list) -> None:
		# エンドポイント (label) ごとにステータスライン分布を出す. 種類がばらけたら
		# レース成立の兆候. multi-endpoint のときは label 単位で見たいので分けて出す.
		groups: dict[str, Counter] = {}
		for r in results:
			if r is None:
				continue
			groups.setdefault(r.label, Counter())[r.status] += 1
		multi = len(groups) > 1
		for label, counter in groups.items():
			if multi:
				logger.info(f'[race] {label}')
			for status, cnt in counter.most_common():
				logger.info(f'[race]   {cnt:3d} x {status}')
		logger.info('[race] done')

	def _inject(self, results: list) -> None:
		"""レスポンスを取り込めたコネクション全部を, 1 本ずつフローとして注入する."""
		injected = 0
		for r in results:
			if r is None or r.raw is None:
				continue
			try:
				resp = self._parse_response(r.raw)
			except Exception as e:  # noqa: BLE001 - パース失敗はスキップ (集計には残る)
				logger.debug(f'[race] response parse failed ({r.label}): {e}')
				continue
			f = self._make_flow(r.request, resp)
			if self.loop is not None:
				self.loop.create_task(self._load(f))
			injected += 1
		if injected:
			logger.info(f'[race] injected {injected} flow(s) into the flow list')

	async def _load(self, f: http.HTTPFlow) -> None:
		try:
			await ctx.master.load_flow(f)
		except Exception as e:  # noqa: BLE001
			logger.debug(f'[race] load_flow failed: {e}')

	@staticmethod
	def _parse_response(raw: bytes) -> http.Response:
		"""レスポンス全文を http.Response にする. chunked はデチャンクして格納する."""
		head, _, body = raw.partition(b'\r\n\r\n')
		resp = read_response_head(head.split(b'\r\n'))
		if 'chunked' in resp.headers.get('transfer-encoding', '').lower():
			body = RaceLastByte._dechunk(body)
			del resp.headers['transfer-encoding']
		# raw_content (オンワイヤのバイト列) として格納する. content-encoding
		# (gzip 等) はヘッダに残るので, flowview 側が表示時にデコードする.
		resp.data.content = body
		now = time.time()
		resp.timestamp_start = now
		resp.timestamp_end = now
		return resp

	@staticmethod
	def _dechunk(data: bytes) -> bytes:
		"""transfer-encoding: chunked のボディをデチャンクする (簡易)."""
		out = b''
		while data:
			line, sep, rest = data.partition(b'\r\n')
			if not sep:
				break
			try:
				n = int(line.split(b';', 1)[0], 16)  # chunk-ext は無視
			except ValueError:
				break
			if n == 0:
				break
			out += rest[:n]
			data = rest[n + 2 :]  # チャンクデータ + 末尾 CRLF を飛ばす
		return out

	@staticmethod
	def _make_flow(request: http.Request, response: http.Response) -> http.HTTPFlow:
		# request は複数 Job で共有される object なので, 注入フローごとに複製して
		# エイリアスを避ける (load_flow 側のアドオンが触っても元に影響しないように).
		client = connection.Client(peername=('127.0.0.1', 0), sockname=('127.0.0.1', 0))
		server = connection.Server(address=(request.host, request.port))
		f = http.HTTPFlow(client, server)
		f.request = request.copy()
		f.response = response
		f.live = False
		f.comment = 'last-byte sync'
		return f


addons = [RaceLastByte()]
