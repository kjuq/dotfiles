# XDG Base Directories (NEED TO LOAD FIRST!!!!)
set -q XDG_CONFIG_HOME; or set --export XDG_CONFIG_HOME "$HOME/.config"
set -q XDG_CACHE_HOME; or set --export XDG_CACHE_HOME "$HOME/.cache"
set -q XDG_DATA_HOME; or set --export XDG_DATA_HOME "$HOME/.local/share"
set -q XDG_STATE_HOME; or set --export XDG_STATE_HOME "$HOME/.local/state"

# User defined
set --export LOCAL_BIN_PATH "$HOME/.local/bin"

# Environment variables
set --export LC_ALL en_US.UTF-8
set --export LANG en_US.UTF-8
set --export LANGUAGE en_US.UTF-8

set --export EDITOR nvim
set --export VISUAL nvim
set --export MANPAGER nvim +Man!

set --export SUDO_ASKPASS "$LOCAL_BIN_PATH/sudo_pass"

# Homebrew
set --export HOMEBREW_NO_ANALYTICS 1
set --export HOMEBREW_NO_ENV_HINTS 1

# w3m
set --export W3M_DIR "$XDG_CONFIG_HOME/w3m"

# GnuPG and password-store
set --export PASSWORD_STORE_DIR "$HOME/password-store"
set --export GPG_TTY (tty)

if [ (uname) = "Linux" ]
	set --export BROWSER "/usr/bin/vivaldi"
end
