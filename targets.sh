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
gtkrc-2.0/gtkrc
hammerspoon/lua
hammerspoon/init.lua
hammerspoon/.luarc.json
i3
kitty/kitty.conf
latexmk/latexmkrc
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
qutebrowser/config.py
spotifyd/spotifyd.conf
tmux/tmux.conf
tmux/scripts
w3m/keymap
wezterm/wezterm.lua
zsh/.zshrc
"

local_bin_files="
acw
cm
cpl
cplus
cpp-submit
cpp-test
floatingnvim
fix_treesitter_parser
nvimcopy
pypy-submit
python-submit
python-test
rclone_init
set_keyrepeat_rate
sudo_pass
toggle_menubar
"

root_files="
.docker/config.json
.clang-format
.ignore
.zshenv
"

library="
"

xdg_to_library="
clangd/config.yaml
"
