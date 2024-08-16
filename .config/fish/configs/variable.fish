# XDG Base Directories (NEED TO LOAD FIRST!!!!)
set -q XDG_CONFIG_HOME; or set --export XDG_CONFIG_HOME "$HOME/.config"
set -q XDG_CACHE_HOME; or set --export XDG_CACHE_HOME "$HOME/.cache"
set -q XDG_DATA_HOME; or set --export XDG_DATA_HOME "$HOME/.local/share"
set -q XDG_STATE_HOME; or set --export XDG_STATE_HOME "$HOME/.local/state"

# User defined
set --export LOCAL_HOME "$HOME/.local"
set --export LOCAL_BIN_PATH "$LOCAL_HOME/bin"

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

# Bash
mkdir --parents "$XDG_STATE_HOME/bash"
set --export HISTFILE "$XDG_STATE_HOME/bash/history"

# w3m
set --export W3M_DIR "$XDG_CONFIG_HOME/w3m"

# rclone
set --export RCLONE_PROGRESS true
set --export RCLONE_EXCLUDE "*.DS_Store"

# GnuPG and password-store
set --export PASSWORD_STORE_DIR "$LOCAL_HOME/password-store"
set --export GPG_TTY (tty)

# Xinit
set --export XINITRC "$XDG_CONFIG_HOME/X11/xinitrc"
set --export XSERVERRC "$XDG_CONFIG_HOME/X11/xserverrc"

# GUI toolkit
set --export GTK2_RC_FILES "$XDG_CONFIG_HOME/gtkrc-2.0/gtkrc"

# Defined at .profile generated by Manjaro
set --export QT_QPA_PLATFORMTHEME "qt5ct"

# Xauthority
if set -q XDG_RUNTIME_DIR
	set --export XAUTHORITY "$XDG_RUNTIME_DIR/Xauthority"
end
