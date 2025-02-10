#!/usr/bin/env bash

set -eu

if [ ! "$(uname)" == "Linux" ]; then
	echo 'This machine is not Linux' 1>&2
	exit 1
fi

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

install() {
	ln --symbolic "$XDG_CONFIG_HOME/alacritty/linux.toml.bak" "$XDG_CONFIG_HOME/alacritty/linux.toml"
	"$script_dir"/pulseaudio.sh install
}

uninstall() {
	f="$XDG_CONFIG_HOME/alacritty/linux.toml" && [ -L "$f" ] && rm "$f" || return 0
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
