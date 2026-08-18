"""mitmproxy アドオン: 追加ツール共通のランチャー (leader キー方式).

mitmproxy の keys.yaml は単キー割当しか持たず chord (前置キー) がないので,
space に「次の 1 キーを受け取る」コマンド (tools.leader) を割り当てて leader
キーとして使う. 組み込みの onekey プロンプト (status_prompt_onekey) を使う
だけで, 独自の UI ウィジェットは作らない.

    space l    # last-byte sync を直接開く
    space ?    # 全ツールの選択メニューを開く (標準チューザー)

ランチャー自体はフローを要求しない (フロー 0 でも開く). フローが要るかは
アクションごとの性質なので Tool.needs_flow で持たせる. フロー必須のアクション
を選んだのにフォーカス中フローが無いときは, 素っ気ないコマンドエラーではなく
status バーメッセージで知らせる (アクションは常に一覧に出す).

ツールを増やすときは TOOLS に 1 行足す. leader キーは 1 文字で重複させない.
? は「メニュー」に予約, esc/enter はプロンプトのキャンセル/確定に使われる.

Tool.ctx は keys.yaml の ctx と同じ概念で, 現在フォーカス中ウィジェットの
keyctx (flowlist / flowview など) がそこに含まれるツールだけをヒント / メニュー
に出す. None なら leader が届くすべてのコンテキストで有効.
"""

from __future__ import annotations

import asyncio
import logging
from collections.abc import Sequence
from typing import NamedTuple

from mitmproxy import command
from mitmproxy import ctx
from mitmproxy import exceptions
from mitmproxy.log import ALERT
from mitmproxy.tools.console import signals

logger = logging.getLogger(__name__)


class Tool(NamedTuple):
	key: str  # leader キー (space に続けて押す 1 文字)
	label: str  # メニュー / ヒントでの表示名
	cmd: str  # 呼ぶコマンド名, または raw=True なら完全なコマンドライン
	needs_flow: bool = True  # フォーカス中フローを渡すか (不要なら False)
	raw: bool = False  # cmd を完全なコマンドラインとして実行するか (下記参照)
	ctx: tuple[str, ...] | None = None  # 有効な key context (None なら常に有効)


# ツール一覧. 増やすときはここに 1 行足す.
# raw=True のツールは cmd を keys.yaml と同じ「コマンドライン文字列」として
# commands.execute で実行する. @focus 等のフロースペックはコマンド側が自分で
# 解決するので needs_flow は無視される (フロー 0 のときのエラーも native と同じ).
TOOLS: list[Tool] = [
	Tool('d', 'quit', 'console.exit', needs_flow=False),
	Tool('t', 'race attack', 'turbo.menu', needs_flow=False, ctx=('flowlist', 'flowview')),
	Tool('c', 'copy method+url+body', 'export.clip method-url-body @focus', raw=True, ctx=('flowlist', 'flowview')),
	Tool('r', 'copy response body', 'export.clip response-body @focus', raw=True, ctx=('flowlist', 'flowview')),
	Tool(
		'C',
		'copy as...',
		'console.choose.cmd "Copy as..." export.formats export.clip {choice} @focus',
		raw=True,
		ctx=('flowlist', 'flowview'),
	),
]

# メニューを開く leader キー (space ?).
MENU_KEY = '?'


class ToolsMenu:
	def __init__(self) -> None:
		self.loop: asyncio.AbstractEventLoop | None = None
		# メニュー (チューザー) を開いた時点でのツール一覧. チューザーは overlay
		# なので開いている間の keyctx は 'chooser' になり, 選択後の tools.run で
		# 再判定すると必ず外れる. 開いた時点の一覧を保持して参照する.
		self._menu_tools: list[Tool] = list(TOOLS)

	def running(self) -> None:
		self.loop = asyncio.get_running_loop()

	# --- context ------------------------------------------------------------

	def _current_keyctx(self) -> str | None:
		"""現在フォーカス中ウィジェットの key context (flowlist / flowview など).

		keys.yaml の ctx と同じ値. 本体の keymap dispatch と同じく
		window.focus_stack().top_widget().keyctx を見る. コンソール UI が
		無い / 未初期化なら None.
		"""
		window = getattr(ctx.master, 'window', None)
		if window is None:
			return None
		try:
			return window.focus_stack().top_widget().keyctx
		except Exception:  # UI 内部構造への依存なので, 壊れても leader は生かす
			return None

	def _visible_tools(self) -> list[Tool]:
		"""現在の key context で有効なツールだけを返す."""
		keyctx = self._current_keyctx()
		return [t for t in TOOLS if t.ctx is None or keyctx in t.ctx]

	# --- leader (space) -----------------------------------------------------

	@command.command('tools.leader')
	def leader(self) -> None:
		"""space に続く 1 キーを受け取り, ツールを開く / メニューを出す.

		ランチャーはフローを要求しないので, フローが 0 個でもプロンプトは開く.
		ctx 付きのツールは現在の key context に合うものだけ出す.
		"""
		tools = self._visible_tools()
		# word は必ず先頭に key 文字を置く. highlight_key は key が word に
		# 無いとクラッシュするため (word.split(key) の parts[1] を参照する).
		keys = [(f'{t.key} {t.label}', t.key) for t in tools]
		keys.append((f'{MENU_KEY} menu', MENU_KEY))
		# ステータスバーはエントリ間を ',' (空白なし) で連結するので, 2 番目
		# 以降の word 先頭に空白を足して ', ' 区切りに見せる. highlight_key は
		# 最初に現れる key 文字をハイライトするため, 先頭空白を足しても崩れない.
		keys = [(w if i == 0 else f' {w}', k) for i, (w, k) in enumerate(keys)]
		by_key = {t.key: t for t in tools}

		def onekey(k: str) -> None:
			if k == MENU_KEY:
				self._open_menu(tools)
			elif k in by_key:
				self._run(by_key[k])

		signals.status_prompt_onekey.send(
			prompt='tools',
			keys=keys,
			callback=onekey,
		)

	# --- menu (space ?) -----------------------------------------------------

	@command.command('tools.menu')
	def menu(self) -> None:
		"""全ツールの選択メニューを開く (標準チューザー)."""
		self._open_menu(self._visible_tools())

	def _open_menu(self, tools: Sequence[Tool]) -> None:
		self._menu_tools = list(tools)
		ctx.master.commands.call(
			'console.choose.cmd',
			'Tools',  # プロンプト
			'tools.actions',  # 選択肢を返すコマンド
			'tools.run',  # 選択後に呼ぶコマンド
			'{choice}',  # 選んだラベルに置換される
		)

	@command.command('tools.actions')
	def actions(self) -> Sequence[str]:
		"""メニューに出すツール一覧 (メニューを開いた時点の context で絞り込み済み)."""
		return [t.label for t in self._menu_tools]

	@command.command('tools.run')
	def run(self, action: str) -> None:
		"""メニューで選ばれたラベルに対応するツールを開く."""
		by_label = {t.label: t for t in self._menu_tools}
		tool = by_label.get(action)
		if tool is None:
			raise exceptions.CommandError(f'Unknown tool: {action}')
		self._run(tool)

	# --- dispatch -----------------------------------------------------------

	def _run(self, tool: Tool) -> None:
		"""ツールを実行. フロー必須なら, その場でフォーカス中フローを解決する."""
		if tool.raw:
			# 完全なコマンドライン. @focus 等はコマンド側が解決するので, フロー
			# 解決はせずそのまま実行する (keys.yaml の単キー割当と等価).
			self._dispatch_line(tool.cmd)
			return
		if not tool.needs_flow:
			self._dispatch(tool.cmd)
			return
		f = ctx.master.view.focus.flow
		if f is None:
			# フロー必須なのに対象が無い. 素っ気ないコマンドエラーの代わりに
			# status バーで知らせる (アクション自体は一覧から消さない).
			signals.status_message.send(message=f'{tool.label}: no flow selected', expire=3)
			return
		self._dispatch(tool.cmd, f)

	def _dispatch(self, cmd: str, *args: object) -> None:
		# チューザーのコールバック内から直接別チューザーを開くと, 選択直後の
		# オーバーレイ pop に巻き込まれて閉じてしまう. 次のループ tick に回す.
		loop = self.loop or asyncio.get_running_loop()
		loop.call_soon(self._call, cmd, args)

	def _dispatch_line(self, line: str) -> None:
		# raw コマンドライン版. _dispatch と同じ理由でループ tick に回す
		# (c の "Copy as..." は別チューザーを開くため).
		loop = self.loop or asyncio.get_running_loop()
		loop.call_soon(self._exec, line)

	def _call(self, cmd: str, args: tuple[object, ...]) -> None:
		try:
			ctx.master.commands.call(cmd, *args)
		except exceptions.CommandError as e:
			logger.log(ALERT, f'[tools] {e}')

	def _exec(self, line: str) -> None:
		try:
			ctx.master.commands.execute(line)
		except exceptions.CommandError as e:
			logger.log(ALERT, f'[tools] {e}')


addons = [ToolsMenu()]
