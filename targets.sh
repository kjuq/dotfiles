#!/usr/bin/env bash

# shellcheck disable=2034
xdg_config_files="
aerc/accounts.conf.template
aerc/aerc.conf
aerc/binds.conf
aerc/stylesets
alacritty/alacritty.yml
alacritty/macos.yml.bak
alacritty/linux.yml.bak
brewfile/Brewfile
clangd/config.yaml
fish/config.fish
fish/configs
git
gitui
hammerspoon/init.lua
i3/config
kitty/kitty.conf
lazygit/config.yml
lesskey
mimeapps.list
neomutt/common_gmail
neomutt/common_outlook
neomutt/mailcap
neomutt/neomuttrc
neomutt/signature
nano/nanorc
nvim
pycodestyle
spotifyd/spotifyd.conf
tmux/tmux.conf
tmux/scripts
wezterm/wezterm.lua
"

local_bin_files="
"

# shellcheck disable=2034
root_files="
.docker/config.json
.clang-format
.gnupg/gpg-agent.conf.bak
.ignore
.ssh/config
.w3m/keymap
scripts
"
