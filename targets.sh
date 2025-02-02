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
clang-format
docker/config.json
dust/config.toml
fd/ignore
fish/config.fish
fish/configs
git
gitui
gnupg/gpg-agent.conf
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
matplotlib/matplotlibrc
mimeapps.list
mypy/config
nb/nbrc
neomutt/color
neomutt/common_gmail
neomutt/common_outlook
neomutt/mailcap
neomutt/neomuttrc
neomutt/signature
nano/nanorc
npm/npmrc
nvim
python/pythonrc.py
qutebrowser/config.py
ripgrep/ripgreprc
ruff/ruff.toml
spotifyd/spotifyd.conf
stylua/stylua.toml
tmux/tmux.conf
tmux/scripts
vim/vimrc
w3m/keymap
w3m/config
wezterm/wezterm.lua
X11
xautocfg.cfg
xremap/config.yml
yay/config.json
zathura/zathurarc
"

local_bin_files="
acw
audiovol
battery
brightmax
brightmin
check_terminal_escape_sequence
clean_dotfiles
cm
cpl
cplus
cpp-submit
cpp-test
cpuset
curfreq
disable_mouse_acceleration
extend_hidpi_display
floatingnvim
fix_treesitter_parser
ggl
idletimer
jman
keyboard_init
nvimcopy
pypy-submit
python-submit
python-test
rclone_init
sudo_pass
toggle_menubar
ttyscreen
vc
x
"

root="
.local/bin_kjuq
"
