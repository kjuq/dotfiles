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
- Terminal Emulator: Kitty
- Terminal Multiplexer: Tmux
- Shell: Fish
- Editor: Neovim

# Usage

## Install

```bash
./main.sh install
```

## Uninstall

```bash
./main.sh uninstall
```

## Backup

```bash
./main.sh backup
```

---

# Neovim

## Local configs

Put files at `$XDG_CONFIG_HOME/nvim/lua/kjuq/rc/local/*`

- `initpost.lua`
- `initpre.lua`
- `pluginpre.lua`

## Environment variables

- `KJUQ_NVIM_NO_EXT_PLUGINS`: Set any value to disable loading external plugins
- `KJUQ_NVIM_LOAD_ALL_RUNTIME_PATH`: Add all external plugins path to LuaLS's library on start

## Global variables

- `_G.kjuq_colorscheme`
- `_G.kjuq_colorscheme_transparent`
- `_G.kjuq_auto_completion`
- `_G.kjuq_auto_copilot_suggestion`
