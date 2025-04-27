#!/usr/bin/env bash

set -u

if [ ! "$(uname)" == "Darwin" ]; then
	echo 'This machine is not MacOS' 1>&2
	exit 1
fi

etc() {
	defaults write org.hammerspoon.Hammerspoon MJConfigFile "$XDG_CONFIG_HOME/hammerspoon/init.lua"
	# These 3 lines need a reboot to apply
	defaults write -g KeyRepeat -int 2         # MacOS's minimum is 2 (30 ms)
	defaults write -g InitialKeyRepeat -int 15 # MacOS's minimum is 15 (225 ms)
	defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
}

install() {
	ln --symbolic "$XDG_CONFIG_HOME/qutebrowser/config.py" "$HOME/.qutebrowser/config.py"
	ln --symbolic "$XDG_CONFIG_HOME/clangd/config.yaml" "$HOME/Library/Preferences/clangd/config.yaml"
}

uninstall() {
	rm "$HOME/.qutebrowser/config.py"
	rm "$HOME/Library/Preferences/clangd/config.yaml"
}

# ------------------------- main ------------------------- #

if [ "$1" == "install" ]; then
	install
	etc
elif [ "$1" == "uninstall" ]; then
	uninstall
else
	echo "Unknown or no argument was given. Quit."
	exit 1
fi
