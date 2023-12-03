#!/usr/bin/env bash

# shellcheck disable=2034
xdg_files="
aerc/accounts.conf.template
aerc/aerc.conf
aerc/binds.conf
aerc/stylesets
alacritty/alacritty.yml
alacritty/macos.yml.bak
alacritty/linux.yml.bak
brewfile/Brewfile
fish/config.fish
fish/configs
git
gitui
hammerspoon/init.lua
i3/config
karabiner/assets
karabiner/karabiner.json
kitty/kitty.conf
lazygit/config.yml
lesskey
neomutt/common_gmail
neomutt/common_outlook
neomutt/mailcap
neomutt/neomuttrc
neomutt/signature
nano/nanorc
nvim
pycodestyle
spotify-tui/config.yml
spotifyd/spotifyd.conf
tmux/tmux.conf
tmux/scripts
wezterm/wezterm.lua
"

# shellcheck disable=2034
files="
.docker/config.json
.clang-format
.gnupg/gpg-agent.conf.bak
.ignore
.mackup
.mackup.cfg
.ssh/config
.w3m/keymap
scripts
Library/Preferences/clangd/config.yaml
"
