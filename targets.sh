#!/usr/bin/env bash

# shellcheck disable=2034
xdg_config_files="
aerc/accounts.conf.template
aerc/aerc.conf
aerc/binds.conf
aerc/stylesets
alacritty/alacritty.toml
alacritty/macos.toml.bak
alacritty/linux.toml.bak
brewfile/Brewfile
clangd/config.yaml
fish/config.fish
fish/configs
git
gitui
hammerspoon/init.lua
hammerspoon/.luarc.json
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
acw
cpl
cplus
cpp-submit
cpp-test
floatingnvim
nvimcopy
pypy-submit
python-submit
python-test
set_keyrepeat_rate
sudo_pass
toggle_menubar
"

# shellcheck disable=2034
root_files="
.docker/config.json
.clang-format
.gnupg/gpg-agent.conf
.ignore
.ssh/config
.w3m/keymap
"
