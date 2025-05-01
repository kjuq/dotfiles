#!/usr/bin/env bash

set -u

if [ -z "${TERMUX_VERSION:-}" ]; then
	echo 'This environment is not Termux. Quit' 1>&2
	exit 1
fi

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

install() {
	! command -v rsync >/dev/null 2>&1 && echo 'rsync is not installed (termux.sh)' 1>&2 && exit 1
	test -e ~/.shortcuts && rm -rf ~/.shortcuts
	rsync --recursive "$script_dir"/../termux/shortcuts/ ~/.shortcuts
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
