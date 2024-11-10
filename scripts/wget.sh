#!/usr/bin/env bash

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

if [ -e "$WGETRC" ]; then
	echo "'wgetrc' already exists. Quit" 1>&2
	exit 1
fi

mkdir --parents "$(dirname "$WGETRC")"

echo "hsts-file = $XDG_CACHE_HOME/wget-hsts" >>"$WGETRC"
