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
	cmd: str  # 呼ぶコマンド名
	needs_flow: bool = True  # フォーカス中フローを渡すか (不要なら False)


# ツール一覧. 増やすときはここに 1 行足す.
TOOLS: list[Tool] = [
	Tool('l', 'last-byte sync', 'race.menu'),
	Tool('d', 'quit', 'console.exit', needs_flow=False),
]

# メニューを開く leader キー (space ?).
MENU_KEY = '?'


class ToolsMenu:
	def __init__(self) -> None:
		self.loop: asyncio.AbstractEventLoop | None = None

	def running(self) -> None:
		self.loop = asyncio.get_running_loop()

	# --- leader (space) -----------------------------------------------------

	@command.command('tools.leader')
	def leader(self) -> None:
		"""space に続く 1 キーを受け取り, ツールを開く / メニューを出す.

		ランチャーはフローを要求しないので, フローが 0 個でもプロンプトは開く.
		"""
		# word は必ず先頭に key 文字を置く. highlight_key は key が word に
		# 無いとクラッシュするため (word.split(key) の parts[1] を参照する).
		keys = [(f'{t.key} {t.label}', t.key) for t in TOOLS]
		keys.append((f'{MENU_KEY} menu', MENU_KEY))
		# ステータスバーはエントリ間を ',' (空白なし) で連結するので, 2 番目
		# 以降の word 先頭に空白を足して ', ' 区切りに見せる. highlight_key は
		# 最初に現れる key 文字をハイライトするため, 先頭空白を足しても崩れない.
		keys = [(w if i == 0 else f' {w}', k) for i, (w, k) in enumerate(keys)]
		by_key = {t.key: t for t in TOOLS}

		def onekey(k: str) -> None:
			if k == MENU_KEY:
				self._open_menu()
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
		self._open_menu()

	def _open_menu(self) -> None:
		ctx.master.commands.call(
			'console.choose.cmd',
			'Tools',  # プロンプト
			'tools.actions',  # 選択肢を返すコマンド
			'tools.run',  # 選択後に呼ぶコマンド
			'{choice}',  # 選んだラベルに置換される
		)

	@command.command('tools.actions')
	def actions(self) -> Sequence[str]:
		"""メニューに出すツール一覧."""
		return [t.label for t in TOOLS]

	@command.command('tools.run')
	def run(self, action: str) -> None:
		"""メニューで選ばれたラベルに対応するツールを開く."""
		by_label = {t.label: t for t in TOOLS}
		tool = by_label.get(action)
		if tool is None:
			raise exceptions.CommandError(f'Unknown tool: {action}')
		self._run(tool)

	# --- dispatch -----------------------------------------------------------

	def _run(self, tool: Tool) -> None:
		"""ツールを実行. フロー必須なら, その場でフォーカス中フローを解決する."""
		if not tool.needs_flow:
			self._dispatch(tool.cmd)
			return
		f = ctx.master.view.focus.flow
		if f is None:
			# フロー必須なのに対象が無い. 素っ気ないコマンドエラーの代わりに
			# status バーで知らせる (アクション自体は一覧から消さない).
			signals.status_message.send(
				message=f'{tool.label}: no flow selected', expire=3
			)
			return
		self._dispatch(tool.cmd, f)

	def _dispatch(self, cmd: str, *args: object) -> None:
		# チューザーのコールバック内から直接別チューザーを開くと, 選択直後の
		# オーバーレイ pop に巻き込まれて閉じてしまう. 次のループ tick に回す.
		loop = self.loop or asyncio.get_running_loop()
		loop.call_soon(self._call, cmd, args)

	def _call(self, cmd: str, args: tuple[object, ...]) -> None:
		try:
			ctx.master.commands.call(cmd, *args)
		except exceptions.CommandError as e:
			logger.log(ALERT, f'[tools] {e}')


addons = [ToolsMenu()]
