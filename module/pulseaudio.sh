#!/usr/bin/env bash

if [ -z "$XDG_CONFIG_HOME" ]; then
	echo 'XDG_CONFIG_HOME is not set. Quit' 1>&2
	exit 1
fi

cookie_path="$XDG_CONFIG_HOME/pulse/cookie"
conf_path="/etc/pulse/client.conf"
line="cookie-file = $cookie_path"

if grep "^$line$" $conf_path >/dev/null; then
	echo "'$conf_path' is already set. Quit." 1>&2
	exit 0
fi

sudo=$([[ -n "${SUDO_ASKPASS}" ]] && echo "sudo -A" || echo "sudo")

install() {
	$sudo mkdir --parents "$(dirname conf_path)"
	echo "$line" | $sudo tee --append $conf_path >/dev/null
}

if [ "$1" == "install" ]; then
	install
else
	echo "Unknown or no argument was given. Quit."
	exit 1
fi
