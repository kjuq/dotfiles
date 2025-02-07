# XDG Base Directories (NEED TO LOAD FIRST!!!!)
set --query XDG_CONFIG_HOME; or set --export XDG_CONFIG_HOME "$HOME/.config"
set --query XDG_CACHE_HOME; or set --export XDG_CACHE_HOME "$HOME/.cache"
set --query XDG_DATA_HOME; or set --export XDG_DATA_HOME "$HOME/.local/share"
set --query XDG_STATE_HOME; or set --export XDG_STATE_HOME "$HOME/.local/state"

# Environment variables
set --export LC_ALL en_US.UTF-8
set --export LANG en_US.UTF-8
set --export LANGUAGE en_US.UTF-8

set --export EDITOR nvim
set --export VISUAL nvim
set --export MANPAGER nvim +Man!
set --export TERMINAL alacritty --command

set --export SUDO_ASKPASS "$HOME/.local/bin_kjuq/sudo_pass"

# Kjuq created
set --export KJUQ_DOCS "$HOME/docs"

# Homebrew
set --export HOMEBREW_NO_ANALYTICS 1
set --export HOMEBREW_NO_ENV_HINTS 1

# Bash
mkdir --parents "$XDG_STATE_HOME/bash"
set --export HISTFILE "$XDG_STATE_HOME/bash/history"

# Docker
set --export DOCKER_CONFIG "$XDG_CONFIG_HOME/docker"

# Python
set --export PYTHONSTARTUP "$XDG_CONFIG_HOME/python/pythonrc.py"
set --export PYTHON_HISTORY "$XDG_STATE_HOME/python/history" # not working so wrote `pythonrc.py` as a workaround
set --export PYTHONPYCACHEPREFIX "$XDG_CACHE_HOME/python" # no `__pycache__`
set --export PYTHONUSERBASE "$XDG_DATA_HOME/python" # base dir where packages will be installed via `pip install --user`

# Go
set --export GOPATH "$XDG_DATA_HOME/go"

# npm
set --export NPM_CONFIG_USERCONFIG "$XDG_CONFIG_HOME/npm/npmrc"

# Cargo
set --export CARGO_HOME "$XDG_DATA_HOME"/cargo

# w3m
set --export W3M_DIR "$XDG_CONFIG_HOME/w3m"

# rclone
set --export RCLONE_PROGRESS true
set --export RCLONE_EXCLUDE "*.DS_Store"

# fzf
set fzf_fd_opts "--hidden --exclude .git"
set --export FZF_DEFAULT_COMMAND "fd --type f $fzf_fd_opts"
set --export FZF_DEFAULT_OPTS '--height 40% --layout=reverse --border'

# ripgrep
set --export RIPGREP_CONFIG_PATH "$XDG_CONFIG_HOME/ripgrep/ripgreprc"

# NuGet
set --export NUGET_PACKAGES "$XDG_CACHE_HOME/NuGetPackages"

# PostgreSQL
set --export PSQL_HISTORY "$XDG_DATA_HOME/psql_history"

# Dotnet
set --export DOTNET_CLI_HOME "$XDG_DATA_HOME"/dotnet

# CUDA
set --export CUDA_CACHE_PATH "$XDG_CACHE_HOME"/nv

# urxvt
set --export RXVT_SOCKET "$XDG_RUNTIME_DIR"/urxvtd

# wgetrc
set --export WGETRC "$XDG_CONFIG_HOME/wget/wgetrc"

# cpanm
set --export PERL_CPANM_HOME "$XDG_CACHE_HOME/cpanm"

# OpenJDK (some applications don't respect this setting)
set --export _JAVA_OPTIONS "-Djava.util.prefs.userRoot=$XDG_CONFIG_HOME/java"

# GnuPG
set --export GNUPGHOME "$XDG_CONFIG_HOME/gnupg"
set --export GPG_TTY (tty)

# tmux
set --export KJUQ_TMUX_ESCAPE "$XDG_STATE_HOME/kjuq_tmuxescape"

# Password-store
set --export PASSWORD_STORE_DIR "$HOME/.local/password-store"

# nb
set --export NBRC_PATH "$XDG_CONFIG_HOME/nb/nbrc"
set --export NB_DIR "$XDG_DATA_HOME/nb"

# Xinit
set --export XINITRC "$XDG_CONFIG_HOME/X11/xinitrc"
# set --export XSERVERRC "$XDG_CONFIG_HOME/X11/xserverrc" # `startx` fails

# GUI toolkit
set --export GTK2_RC_FILES "$XDG_CONFIG_HOME/gtkrc-2.0/gtkrc"

# Defined at .profile generated by Manjaro
set --export QT_QPA_PLATFORMTHEME "qt5ct"

# Xauthority
if set -q XDG_RUNTIME_DIR
	set --export XAUTHORITY "$XDG_RUNTIME_DIR/Xauthority"
end
