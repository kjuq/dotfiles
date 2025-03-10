#!/usr/bin/env bash

set -eu

if [ -z "$XDG_CONFIG_HOME" ]; then
	echo "XDG_CONFIG_HOME is not set. Quit." 1>&2
	exit 1
fi

if [ -z "$XDG_CACHE_HOME" ]; then
	echo "XDG_CACHE_HOME is not set. Quit" 1>&2
	exit 1
fi

if [ -z "$WGETRC" ]; then
	echo "WGETRC is not set. Quit" 1>&2
	exit 1
fi

install() {
	if [ -e "$WGETRC" ]; then
		# echo "'wgetrc' already exists. Skipped" 1>&2
		return 0
	fi

	mkdir --parents "$(dirname "$WGETRC")"
	echo "hsts-file = $XDG_CACHE_HOME/wget-hsts" >>"$WGETRC"
	echo "'wgetrc' is successfully created"
}

uninstall() {
	f="$WGETRC" && test -e "$f" && rm "$f" || return 0
}

if [ "$1" == "install" ]; then
	install
elif [ "$1" == "uninstall" ]; then
	uninstall
else
	echo "Unknown or no argument was given. Quit."
	exit 1
fi
