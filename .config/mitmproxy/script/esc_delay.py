"""Esc キー押下後の待ち時間 (urwid の complete_wait) をなくす"""

from mitmproxy import ctx

delay_seconds: float = 0.01


class EscDelay:
	def running(self):
		ui = getattr(ctx.master, 'ui', None)
		if ui is None:
			return  # mitmdump / mitmweb には ui がないので何もしない
		ui.set_input_timeouts(complete_wait=delay_seconds)


addons = [EscDelay()]
