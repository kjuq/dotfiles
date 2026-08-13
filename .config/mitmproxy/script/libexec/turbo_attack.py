# Turbo Intruder headless スクリプト (turbo_race.py アドオンから呼ばれる).
#
# これは mitmproxy のアドオンではなく, Turbo Intruder の jar に渡して jar 内蔵の
# Jython (2.7) で実行される attack スクリプト. したがって config.yaml の scripts
# には登録しない. Python 3 の構文 (f-string, 型ヒント) は使えない点に注意.
#
# 呼び出し (turbo_race.py が組み立てる):
#   java -jar turbo-intruder-all.jar turbo_attack.py <requestFile> <endpoint> <wordlistFile>
#
# エンジンと本数はアドオンが環境変数で渡す (argv 末尾の wordlist 規約と衝突させない):
#   TURBO_ENGINE    HTTP2 (single-packet attack) または THREADED (last-byte sync)
#   TURBO_REQUESTS  同時に撃つリクエスト本数
#
# gate 方式:
#   全リクエストを gate 付きで queue しておき, openGate で一斉に解放する. これが
#   Turbo Intruder のレースの肝. HTTP2 エンジンなら single-packet attack として,
#   THREADED エンジンなら各コネクションの last-byte sync として解放される.

from __future__ import print_function


def _env(name, default):
	# jar 内蔵 Jython は JVM 環境変数を os.environ に載せるが, 環境差を避けるため
	# java.lang.System.getenv にもフォールバックする.
	try:
		import os
		v = os.environ.get(name)
		if v:
			return v
	except Exception:
		pass
	try:
		from java.lang import System
		v = System.getenv(name)
		if v:
			return v
	except Exception:
		pass
	return default


def _requests():
	try:
		n = int(_env('TURBO_REQUESTS', '20'))
	except ValueError:
		n = 20
	return max(1, n)


def queueRequests(target, wordlists):
	engine_name = _env('TURBO_ENGINE', 'HTTP2').upper()
	n = _requests()

	if engine_name == 'THREADED':
		# last-byte sync: 各リクエストに 1 コネクションを割り当て, 最終バイトを
		# 保留したまま揃えて解放する.
		engine = RequestEngine(
			endpoint=target.endpoint,
			concurrentConnections=n,
			engine=Engine.THREADED,
		)
	else:
		# single-packet attack: 1 コネクション (HTTP/2) の 1 パケットに全リクエスト
		# を載せて撃つ. HTTP/2 レースの本命.
		engine = RequestEngine(
			endpoint=target.endpoint,
			concurrentConnections=1,
			engine=Engine.HTTP2,
		)

	print('[turbo_attack] engine=%s requests=%d endpoint=%s' % (engine_name, n, target.endpoint))

	for _ in range(n):
		engine.queue(target.req, gate='race1')
	# 全リクエストを一斉解放 (レースの引き金).
	engine.openGate('race1')


def handleResponse(req, interesting):
	# 各レスポンスを結果テーブルに積む. headless 実行では stdout に集計が出るので
	# アドオン側 (turbo_race.py) がイベントログに転記する.
	table.add(req)
