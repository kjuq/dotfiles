# Overview

My ultimate dotfiles.

- OS: Linux
	- ~MacOS~
		- I realized Linux is much more fun :)
	- ~Manjaro~
		- Planning to move to Arch linux once I understand how Linux works perfectly
			- I understood how Linux works perfectly
	- Arch Linux
- Window manager: i3
- Terminal Emulator: Wezterm
- Terminal Multiplexer: Tmux
- Shell: Fish
- Editor: Neovim

# Usage

## Backup

`./main.sh b` backs up files listed in `targets.sh`

## Sync

`./main.sh s` creates symlinks

## Uninstall (unlink symlinks)

TODO

# `scripts/`

Run the scripts in this directory **manually**.

```bash
find ./scripts -name '*.sh' -exec bash {} \;
```
