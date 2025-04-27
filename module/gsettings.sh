#!/usr/bin/env bash

set -eu

if [ -z "$XDG_CONFIG_HOME" ]; then
	echo 'XDG_CONFIG_HOME is not set. gsettings.sh is skipped' 1>&2
	exit 1
fi

if { ! command -v gsettings >/dev/null; } 2>&1; then
	echo 'gsettings is not installled. gsettings.sh is skipped' 1>&2
	exit 1
fi

install() {
	gsettings set org.gtk.Settings.FileChooser sort-directories-first true
}

if [ "$1" == "install" ]; then
	install
else
	echo "Unknown or no argument was given. Quit."
	exit 1
fi
