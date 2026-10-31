"""save_stream_file 設定時に statusbar 右側へ出る [W:...] を隠す.

-w (save_stream_file) を使うと statusbar に保存先パスが [W:...] として常時
表示される. これを消すために StatusBar.get_status の戻り値から [W:...] の
トークンだけ落とす (mitmproxy 本体の statusbar 描画を monkeypatch する).
mitmproxy 12.x の内部構造に依存する点に注意.

パッチは running() ではなく import 時 (= スクリプト読み込み時, UI 構築前) に
当てる. running() まで待つと statusbar の初回描画が先に走り, 起動直後に
[W:...] が一瞬見えてしまうため.
"""

from mitmproxy import ctx
from mitmproxy.tools.console import statusbar


def _install() -> None:
	if getattr(statusbar.StatusBar, '_hide_write_patched', False):
		return  # 二重パッチ (リロード時の再 import 等) を防ぐ

	orig_get_status = statusbar.StatusBar.get_status

	def patched_get_status(self):
		# [W:...] だけ落とす. 他のトークン ([scripts:N] や色付き markup) は残す.
		return [token for token in orig_get_status(self) if not (isinstance(token, str) and token.startswith('[W:'))]

	statusbar.StatusBar.get_status = patched_get_status
	statusbar.StatusBar._hide_write_patched = True


# import 時点でクラスメソッドを差し替える. これで最初の描画から [W:...] は出ない.
_install()


class HideWriteIndicator:
	def running(self) -> None:
		# import 時に当たっているはずだが, 念のため再適用 (idempotent) し,
		# 表示中の statusbar を再描画する.
		_install()
		win = getattr(ctx.master, 'window', None)
		if win is not None:  # mitmdump / mitmweb には TUI がない
			win.refresh()


addons = [HideWriteIndicator()]
