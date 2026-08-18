"""タイトルバーを左クリックできる「戻るボタン」にする"""

from mitmproxy import ctx
from mitmproxy.tools.console import window as console_window

BACK_LABEL = '  [ ← Back ]'


def _poppable(window, body) -> bool:
	"""この画面に戻り先があるか (最上位のフローリストでは False)"""
	for s in window.stacks:
		if s.top_widget() is body:
			return s.overlay is not None or len(s.stack) > 1
	return False


class TitleBarBack:
	def running(self):
		win = getattr(ctx.master, 'window', None)
		if win is None:  # mitmdump / mitmweb には TUI がない
			return
		if getattr(console_window.StackWidget, '_back_button_patched', False):
			return  # スクリプトのリロード時に二重パッチしない

		orig_init = console_window.StackWidget.__init__
		orig_mouse = console_window.StackWidget.mouse_event

		def patched_init(self, window, widget, title, focus):
			if title and _poppable(window, widget):
				title = title + BACK_LABEL
			orig_init(self, window, widget, title, focus)

		def patched_mouse(self, size, event, button, col, row, focus):
			if (
				event == 'mouse press'
				and button == 1
				and row == 0
				and self.header is not None
				and self.is_focused
				and _poppable(self.window, self.body)
			):
				ctx.master.commands.call('console.view.pop')
				return True
			return orig_mouse(self, size, event, button, col, row, focus)

		console_window.StackWidget.__init__ = patched_init
		console_window.StackWidget.mouse_event = patched_mouse
		console_window.StackWidget._back_button_patched = True
		win.refresh()  # 表示中の画面にも反映


addons = [TitleBarBack()]
