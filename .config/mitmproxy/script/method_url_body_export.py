"""PacketProxy の「copy Method + URL + Body」と同じ形式のエクスポートを追加する"""

from mitmproxy import exceptions, flow, http
from mitmproxy.addons import export


def method_url_body(f: flow.Flow) -> str:
	if not isinstance(f, http.HTTPFlow) or not f.request:
		raise exceptions.CommandError("Can't export flow with no request.")
	req = f.request
	body = req.get_text(strict=False) or ''
	return f'{req.method}\t{req.pretty_url}\t{body}'


export.formats['method-url-body'] = method_url_body
