#!/usr/bin/env bash

set -eu

# check if XDG_CONFIG_HOME is set
if [ -z "$XDG_CONFIG_HOME" ]; then
	echo "XDG_CONFIG_HOME is not set. Quit." 1>&2
	exit 1
fi

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

backup() {
	while read -r line; do
		local="$(eval echo "$line")"
		remote="${local//$HOME/$script_dir}"
		mkdir --parents "$(dirname remote)"
		echo "$local" "$remote"
	done <"$script_dir"/targets.txt
}

symlink() {
	while read -r line; do
		local="$(eval echo "$line")"
		remote="${local//$HOME/$script_dir}"
		mkdir --parents "$(dirname local)"
		echo "$remote" "$local"
	done <"$script_dir"/targets.txt
}

unlink() {
	while read -r line; do
		local="$(eval echo "$line")"
		echo "unlink" "$local"
	done <"$script_dir"/targets.txt
}

linux_etc() {
	if [ ! "$(uname)" == "Linux" ]; then
		echo 'This machine is not Linux' 1>&2
		exit 1
	fi
	link_other "$XDG_CONFIG_HOME/alacritty/linux.toml.bak" "$XDG_CONFIG_HOME/alacritty/linux.toml"
}

macos_etc() {
	if [ ! "$(uname)" == "Darwin" ]; then
		echo 'This machine is not MacOS' 1>&2
		exit 1
	fi
	link_other "$XDG_CONFIG_HOME/alacritty/macos.toml.bak" "$XDG_CONFIG_HOME/alacritty/macos.toml"
	link_other "$XDG_CONFIG_HOME/qutebrowser/config.py" "$HOME/.qutebrowser/config.py"
	link_other "$XDG_CONFIG_HOME/clangd/config.yaml" "$HOME/Library/Preferences/clangd/config.yaml"
	defaults write org.hammerspoon.Hammerspoon MJConfigFile "$XDG_CONFIG_HOME/hammerspoon/init.lua"
	# These 3 lines need a reboot to apply
	defaults write -g KeyRepeat -int 2         # MacOS's minimum is 2 (30 ms)
	defaults write -g InitialKeyRepeat -int 15 # MacOS's minimum is 15 (225 ms)
	defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
}

# ------------------------- main ------------------------- #

if [ "$1" == "backup" ] || [ "$1" == "b" ]; then
	backup
elif [ "$1" == "symlink" ] || [ "$1" == "s" ]; then
	symlink
elif [ "$1" == "unlink" ] || [ "$1" == "u" ]; then
	unlink
elif [ "$1" == "linux" ]; then
	linux_etc
elif [ "$1" == "macos" ]; then
	macos_etc
else
	echo "Unknown or no argument was given. Quit."
	exit 1
fi
