"""レスポンスボディを人間に読める形でエクスポートする.

cut.clip @focus response.content は bytes を repr() で文字列化する仕様
(mitmproxy/addons/cut.py の extract_str) なので, 日本語などが
b'{"message":"item_num\\xe3\\x81\\x8c..."}' の形でクリップボードに載ってしまう.

代わりに export フォーマット 'response-body' を登録する. content-encoding
(gzip 等) と charset を解決してテキスト化し, JSON なら ensure_ascii=False で
pretty print して非 ASCII 文字もそのまま読めるようにする. JSON でなければ
デコードしたテキストをそのまま返す.
"""

import json

from mitmproxy import exceptions, flow, http
from mitmproxy.addons import export


def response_body(f: flow.Flow) -> str:
	if not isinstance(f, http.HTTPFlow) or not f.response:
		raise exceptions.CommandError("Can't export flow with no response.")
	# strict=False: デコードできないバイトは置換して, コマンドエラーにしない.
	text = f.response.get_text(strict=False) or ''
	try:
		obj = json.loads(text)
	except json.JSONDecodeError:
		return text
	return json.dumps(obj, ensure_ascii=False, indent=4)


export.formats['response-body'] = response_body
