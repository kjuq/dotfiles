#!/usr/bin/env bash

# check if XDG_CONFIG_HOME is set
if [ -z "$XDG_CONFIG_HOME" ]; then
	echo "XDG_CONFIG_HOME is not set. Quit." 1>&2
	exit 1
fi

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

xdg_config_without_prefix="${XDG_CONFIG_HOME/$HOME\//}"
script_xdg_config="$script_dir/$xdg_config_without_prefix"

source "$script_dir/targets.sh"

backup() {
	target_file="$1"
	dirtype="$2"

	# Set a source path and a destination path based on a second argument
	if [ "$dirtype" == "xdg_config" ]; then
		src="$XDG_CONFIG_HOME/$target_file"
		dst="$script_xdg_config/$target_file"
		parent_dir="$script_xdg_config/$(dirname "$target_file")"
	elif [ "$dirtype" == "root" ]; then
		src="$HOME/$target_file"
		dst="$script_dir/$target_file"
		parent_dir="$(dirname "$target_file")"
	else
		echo "XDG option is invalid." 1>&2
		echo "Target: $target_file" 1>&2
		exit 1
	fi

	if [ -L "$src" ]; then
		return 0
	fi

	echo "Backing up: $src"

	# Create directories including parent ones
	if ! [ -d "$parent_dir" ]; then
		mkdir --parents "$parent_dir"
	fi

	# Copy directory or file
	if [ -d "$src" ]; then
		cp -r "$src" "$(dirname "$dst")"
	else
		cp "$src" "$dst"
	fi
}

symlink() {
	target_file="$1"
	dirtype="$2"

	# Set a source path and a destination path based on a second argument
	if [ "$dirtype" == "xdg_config" ]; then
		src="$script_xdg_config/$target_file"
		dst="$XDG_CONFIG_HOME/$target_file"
		parent_dir="$XDG_CONFIG_HOME/$(dirname "$target_file")"
	elif [ "$dirtype" == "root" ]; then
		src="$script_dir/$target_file"
		dst="$HOME/$target_file"
		parent_dir="$HOME/$(dirname "$target_file")"
	else
		echo "XDG option is invalid." 1>&2
		echo "Target: $target_file" 1>&2
		exit 1
	fi

	echo "Creating Symlink: $src"

	# Create directories including parent ones
	if ! [ -d "$parent_dir" ]; then
		mkdir --parents "$parent_dir"
	fi

	# Create a symlink
	# Delete a pre-exist link
	if [ -L "$dst" ]; then
		return 0
	fi
	# Delete a pre-exist dir/file
	if [ -e "$dst" ]; then
		read -r -p "$dst already exists. Delete it? (y/N) " INPUT
		if [ "$INPUT" == "y" ] || [ "$INPUT" == "Y" ]; then
			if [ -d "$dst" ]; then
				rm -r "$dst"
			elif [ -f "$dst" ]; then
				rm "$dst"
			else
				echo "Unknown Filetype Error: when deleting $dst" 1>&2
				exit 1
			fi
		else
			return 0
		fi
	fi
	ln --symbolic "$src" "$dst"
}

unsymlink() {
	false
	# TODO: remove symlinks and restore real files
}

link_other() {
	src="$1"
	dst="$2"

	if [ -L "$dst" ]; then
		return 0
	fi

	echo "Symlinking: $dst"

	ln -s "$src" "$dst"
}

unlink_other() {
	false
	# TODO
}

linux_etc() {
	link_other "$XDG_CONFIG_HOME/alacritty/linux.toml.bak" "$XDG_CONFIG_HOME/alacritty/linux.toml"
}

macos_etc() {
	link_other "$XDG_CONFIG_HOME/alacritty/macos.toml.bak" "$XDG_CONFIG_HOME/alacritty/macos.toml"
	link_other "$XDG_CONFIG_HOME/qutebrowser/config.py" "$HOME/.qutebrowser/config.py"
	link_other "$XDG_CONFIG_HOME/clangd/config.yaml" "$HOME/Library/Preferences/clangd/config.yaml"

	# These 3 lines need reboot to apply
	defaults write -g KeyRepeat -int 2         # MacOS's minimum is 2 (30 ms)
	defaults write -g InitialKeyRepeat -int 15 # MacOS's minimum is 15 (225 ms)
	defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

	defaults write org.hammerspoon.Hammerspoon MJConfigFile "$XDG_CONFIG_HOME/hammerspoon/init.lua"
}

main() {
	if [ "$1" == "backup" ] || [ "$1" == "b" ]; then
		action="backup"
	elif [ "$1" == "symlink" ] || [ "$1" == "s" ]; then
		action="symlink"
	else
		echo "Unknown or no argument was given. Quit."
		exit 1
	fi

	IFS_BAK=$IFS
	IFS=$'\n'
	for f in $xdg_config_files; do
		IFS=$IFS_BAK
		if ! [ "$f" == "" ]; then
			if [ "$action" == "backup" ]; then
				backup "$f" "xdg_config"
			elif [ "$action" == "symlink" ]; then
				symlink "$f" "xdg_config"
			fi
		fi
	done

	IFS_BAK=$IFS
	IFS=$'\n'
	for f in $root; do
		IFS=$IFS_BAK
		if ! [ "$f" == "" ]; then
			if [ "$action" == "backup" ]; then
				backup "$f" "root"
			elif [ "$action" == "symlink" ]; then
				symlink "$f" "root"
			fi
		fi
	done

	if [ "$(uname)" == "Linux" ]; then
		linux_etc
	fi

	if [ "$(uname)" == "Darwin" ]; then
		macos_etc
	fi
}

main "$1"
