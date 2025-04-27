#!/usr/bin/env bash

set -eu

if [ -z "$TERMUX_VERSION" ]; then
	echo 'Termux does not need pulseaudio.sh. Quit' 1>&2
	exit 1
fi

if [ -z "$XDG_CONFIG_HOME" ]; then
	echo 'XDG_CONFIG_HOME is not set. Quit' 1>&2
	exit 1
fi

cookie_path="$XDG_CONFIG_HOME/pulse/cookie"
conf_path="/etc/pulse/client.conf"
line="cookie-file = $cookie_path"

sudo=$([[ -n "${SUDO_ASKPASS}" ]] && echo "sudo -A" || echo "sudo")

install() {
	if grep "^$line$" $conf_path >/dev/null; then
		# echo "'$line' is already set at '$conf_path'. Skipped."
		return 0
	fi

	$sudo mkdir --parents "$(dirname conf_path)"
	echo "$line" | $sudo tee --append $conf_path >/dev/null
	echo "'$line' is successfully set at '$conf_path'"
}

if [ "$1" == "install" ]; then
	install
else
	echo "Unknown or no argument was given. Quit."
	exit 1
fi
