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
i3status
kitty/kitty.conf
latexmk/latexmkrc
lazygit/config.yml
lesskey
mimeapps.list
mypy/config
neomutt/common_gmail
neomutt/common_outlook
neomutt/mailcap
neomutt/neomuttrc
neomutt/signature
nano/nanorc
nvim
qutebrowser/config.py
ruff/ruff.toml
spotifyd/spotifyd.conf
stylua/stylua.toml
tmux/tmux.conf
tmux/scripts
w3m/keymap
wezterm/wezterm.lua
X11
"

local_bin_files="
acw
brightmax
brightmin
cm
cpl
cplus
cpp-submit
cpp-test
disable_mouse_acceleration
extend_hidpi_display
floatingnvim
fix_treesitter_parser
keyboard_init
nvimcopy
pypy-submit
python-submit
python-test
rclone_init
sudo_pass
toggle_menubar
vc
"

root_files="
.clang-format
.docker/config.json
.gnupg/gpg-agent.conf
.ignore
.textlintrc.json
"

library="
"

xdg_to_library="
clangd/config.yaml
"
