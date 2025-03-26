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
		if [ ! -e "$remote" ]; then
			mkdir --parents "$(dirname "$remote")"
			echo "$local"
			mv "$local" "$remote"
		fi
	done <"$script_dir"/targets.txt
}

symlink() {
	while read -r line; do
		local="$(eval echo "$line")"
		remote="${local//$HOME/$script_dir}"
		mkdir --parents "$(dirname "$local")"
		if [ -L "$local" ]; then
			# The target is already symlinked
			continue
		fi
		ln --symbolic "$remote" "$local"
	done <"$script_dir"/targets.txt
}

unlink() {
	status=0
	while read -r line; do
		local="$(eval echo "$line")"
		if [ -L "$local" ]; then # is symlink
			rm "$local"
		elif [ -e "$local" ]; then
			echo "$local"
			status=1
		fi
	done <"$script_dir"/targets.txt
	return $status
}

install() {
	symlink
	"$script_dir"/module/wget.sh install
	if [ "$(uname)" == "Linux" ]; then
		"$script_dir/module/linux.sh" install
	elif [ "$(uname)" == "Darwin" ]; then
		"$script_dir"/module/macos.sh install
	else
		echo "Unknown OS detected" 1>&2
		return 1
	fi
}

uninstall() {
	unlink
	"$script_dir"/module/wget.sh uninstall
	if [ "$(uname)" == "Linux" ]; then
		"$script_dir"/module/linux.sh uninstall
	elif [ "$(uname)" == "Darwin" ]; then
		"$script_dir"/module/macos.sh uninstall
	else
		echo "Unknown OS detected" 1>&2
		return 1
	fi
}

# ------------------------- main ------------------------- #

if [ "$1" == "install" ] || [ "$1" == "i" ]; then
	install
elif [ "$1" == "uninstall" ] || [ "$1" == "u" ]; then
	uninstall
elif [ "$1" == "backup" ] || [ "$1" == "b" ]; then
	backup
else
	echo "Unknown or no argument was given. Quit."
	exit 1
fi
