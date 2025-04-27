#!/usr/bin/env bash

set -u

if [ ! "$(uname)" == "Linux" ]; then
	echo 'This machine is not Linux. linux.sh is quitted' 1>&2
	exit 1
fi

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

install() {
	"$script_dir"/pulseaudio.sh install
	"$script_dir"/gsettings.sh install
}

uninstall() {
	: # `:` creates empty block. It is similar to `pass` in Python
}

# ------------------------- main ------------------------- #

if [ "$1" == "install" ]; then
	install
elif [ "$1" == "uninstall" ]; then
	uninstall
else
	echo "Unknown or no argument was given. Quit."
	exit 1
fi
