"""esc で mitmproxy が終了しないようにする (終了確認プロンプトも出さない).

デフォルトでは esc は console.view.pop にバインドされ, 最上位で押すと
ConsoleMaster.prompt_for_exit が呼ばれて "Quit (yes,no)?" の確認が出る.
esc を本コマンド console.view.pop_no_exit に差し替え (keys.yaml),
サブ画面 / オーバーレイでは通常通り「戻る」, 最上位では何もしないようにする.
pop 処理自体は公式経路 (pop_view_state シグナル) のまま, 最上位到達時の
prompt_for_exit だけを一時的に無効化して呼ぶ. q の終了確認 (console.view.pop)
や space d の即終了 (console.exit) には影響しない.
"""

from mitmproxy import command
from mitmproxy import ctx
from mitmproxy.tools.console import signals


class EscNoQuit:
	@command.command('console.view.pop_no_exit')
	def view_pop_no_exit(self) -> None:
		"""Pop a view off the console stack; do nothing at the top level."""
		master = ctx.master
		# ConsoleMaster 以外 (mitmdump / mitmweb) には prompt_for_exit が無い
		if not hasattr(master, 'prompt_for_exit'):
			return
		# pop_view_state は同期シグナルで, 最上位なら Window.pop が
		# master.prompt_for_exit() を呼ぶ. その間だけ no-op に差し替える.
		orig = master.prompt_for_exit
		master.prompt_for_exit = lambda: None
		try:
			signals.pop_view_state.send()
		finally:
			master.prompt_for_exit = orig


addons = [EscNoQuit()]
