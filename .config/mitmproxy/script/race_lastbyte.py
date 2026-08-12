"""mitmproxy アドオン: last-byte synchronization レースコンディション送信.

フォーカス中の HTTP リクエストを, 各コネクションで最終 1 バイトだけ保留し,
threading.Barrier で足並みを揃えてから一斉に送出する. mitmproxy 本体の
プロキシ/リプレイ経路は使わず, アドオン内で独自に raw ソケットを開くため,
last-byte sync に必要なバイト単位の送出制御ができる.

使い方 (TUI コマンド欄 or キーバインド):
	:race.menu @focus              # 選択メニューを開く (キーバインド不要)
	:race.lastbyte @focus          # デフォルト 20 本
	:race.lastbyte @focus 30       # 30 本

mitmproxy はキャプチャ・トリガ・UI・リクエスト組み立てを担当し, 実際の
送信だけをこのアドオンが行う, という役割分担.
"""

from __future__ import annotations

import asyncio
import logging
import socket
import ssl
import threading
from collections import Counter
from collections.abc import Sequence

from mitmproxy import command
from mitmproxy import ctx
from mitmproxy import exceptions
from mitmproxy import flow
from mitmproxy import http
from mitmproxy.log import ALERT
from mitmproxy.net.http.http1 import assemble

logger = logging.getLogger(__name__)

TIMEOUT = 10.0
RECV_CAP = 65536

# 選択メニューに並べるアクション. ラベル -> (種別, 本数).
# 種別を分けてあるので, 将来 single-packet の受け渡し等も同じメニューに足せる.
RACE_ACTIONS: dict[str, tuple[str, int]] = {
	'last-byte sync x10': ('lastbyte', 10),
	'last-byte sync x20': ('lastbyte', 20),
	'last-byte sync x50': ('lastbyte', 50),
	'last-byte sync x100': ('lastbyte', 100),
}


class RaceLastByte:
	def __init__(self) -> None:
		self.loop: asyncio.AbstractEventLoop | None = None

	def running(self) -> None:
		# ワーカースレッドから結果をログするときに使うループ参照を保持
		self.loop = asyncio.get_running_loop()

	# --- 自前の選択メニュー -------------------------------------------------
	# キーバインドを消費せず, コマンドバーから :race.menu @focus で開ける.
	# console.choose.cmd がチューザーのオーバーレイを出し, 選んだラベルで
	# {choice} を置換して race.run を呼ぶ.

	@command.command('race.menu')
	def menu(self, f: flow.Flow) -> None:
		"""フォーカス中のフローに対する race アタックの選択メニューを開く."""
		if not isinstance(f, http.HTTPFlow) or not f.request:
			raise exceptions.CommandError("Can't race a flow with no request.")
		ctx.master.commands.call(
			'console.choose.cmd',
			'Race attack',  # プロンプト
			'race.actions',  # 選択肢を返すコマンド
			'race.run',  # 選択後に呼ぶコマンド
			'@focus',
			'{choice}',  # 選んだラベルに置換される
		)

	@command.command('race.actions')
	def actions(self) -> Sequence[str]:
		"""選択メニューに出す項目一覧."""
		return list(RACE_ACTIONS.keys())

	@command.command('race.run')
	def run(self, f: flow.Flow, action: str) -> None:
		"""メニューで選ばれたラベルに対応する race を実行する."""
		if action not in RACE_ACTIONS:
			raise exceptions.CommandError(f'Unknown race action: {action}')
		kind, count = RACE_ACTIONS[action]
		if kind == 'lastbyte':
			self.lastbyte(f, count)
		else:
			raise exceptions.CommandError(f'Unsupported race kind: {kind}')

	# --- 実行本体 -----------------------------------------------------------

	@command.command('race.lastbyte')
	def lastbyte(self, f: flow.Flow, count: int = 20) -> None:
		"""last-byte sync でフォーカス中のリクエストを count 本同時送出する."""
		if not isinstance(f, http.HTTPFlow) or not f.request:
			raise exceptions.CommandError("Can't race a flow with no request.")
		if count < 2:
			raise exceptions.CommandError('count must be >= 2.')

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

		host = req.host
		port = req.port
		use_tls = req.scheme == 'https'
		head, last = raw[:-1], raw[-1:]

		logger.log(
			ALERT,
			f'[race] last-byte sync start: {req.method} {req.pretty_url} ({count} conns, tls={use_tls})',
		)

		# asyncio ループを止めないよう, 送信一式はワーカースレッドへ逃がす
		threading.Thread(
			target=self._run,
			args=(host, port, use_tls, head, last, count),
			name='race.lastbyte',
			daemon=True,
		).start()

	def _run(
		self,
		host: str,
		port: int,
		use_tls: bool,
		head: bytes,
		last: bytes,
		count: int,
	) -> None:
		barrier = threading.Barrier(count)
		results: list = [None] * count
		threads = [
			threading.Thread(
				target=self._worker,
				args=(i, host, port, use_tls, head, last, barrier, results),
				daemon=True,
			)
			for i in range(count)
		]
		for t in threads:
			t.start()
		for t in threads:
			t.join()
		# ログ出力は UI と同じループスレッドに戻して行う
		if self.loop is not None:
			self.loop.call_soon_threadsafe(self._report, results)

	@staticmethod
	def _worker(
		idx: int,
		host: str,
		port: int,
		use_tls: bool,
		head: bytes,
		last: bytes,
		barrier: threading.Barrier,
		results: list,
	) -> None:
		try:
			sock: socket.socket = socket.create_connection((host, port), timeout=TIMEOUT)
			if use_tls:
				ssl_ctx = ssl.create_default_context()
				ssl_ctx.check_hostname = False
				ssl_ctx.verify_mode = ssl.CERT_NONE
				ssl_ctx.set_alpn_protocols(['http/1.1'])
				sock = ssl_ctx.wrap_socket(sock, server_hostname=host)
			sock.setsockopt(socket.IPPROTO_TCP, socket.TCP_NODELAY, 1)
			# 最終バイト以外を先送りし, サーバを受信待ちにさせる
			sock.sendall(head)
		except Exception as e:  # noqa: BLE001 - 接続段階のエラーはそのまま報告
			results[idx] = f'CONNECT_ERR: {e}'
			barrier.abort()  # 揃わないと分かった時点で全員を解放
			return

		try:
			barrier.wait()  # 全スレッドがここで揃う
		except threading.BrokenBarrierError:
			results[idx] = 'BARRIER_BROKEN'
			sock.close()
			return

		try:
			sock.sendall(last)  # レースの引き金: 最終バイトを一斉送出
			sock.settimeout(TIMEOUT)
			resp = b''
			while True:
				chunk = sock.recv(RECV_CAP)
				if not chunk:
					break
				resp += chunk
				if len(resp) > RECV_CAP:
					break
			results[idx] = resp.split(b'\r\n', 1)[0].decode(errors='replace') or 'EMPTY'
		except Exception as e:  # noqa: BLE001
			results[idx] = f'SEND_ERR: {e}'
		finally:
			sock.close()

	def _report(self, results: list) -> None:
		# レスポンスのステータスライン分布を出す. 種類がばらけたらレース成立の兆候
		for status, cnt in Counter(results).most_common():
			logger.log(ALERT, f'[race]   {cnt:3d} x {status}')
		logger.log(ALERT, '[race] done')


addons = [RaceLastByte()]
