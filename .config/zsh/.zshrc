# Setup XDG (Start) {{{

# XDG Base Directories (NEED TO LOAD FIRST!!!!)
[ -z "$XDG_CONFIG_HOME" ] && export XDG_CONFIG_HOME="$HOME/.config"
[ -z "$XDG_CACHE_HOME" ] && export XDG_CACHE_HOME="$HOME/.cache"
[ -z "$XDG_DATA_HOME" ] && export XDG_DATA_HOME="$HOME/.local/share"
[ -z "$XDG_STATE_HOME" ] && export XDG_STATE_HOME="$HOME/.local/state"

export HISTFILE="$XDG_STATE_HOME/zsh/history"
autoload -U compinit
mkdir --parents "$XDG_CACHE_HOME/zsh"
compinit -d "$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION"
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/zcompcache"

# Setup XDG (End) }}}

#  Plugins (Start) {{{

# Install Zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Plugins
zinit light https://github.com/sindresorhus/pure # Best prompt theme ever
zinit light zsh-users/zsh-syntax-highlighting # Syntax highlighling

zinit light zsh-users/zsh-autosuggestions # Completion based on history
zinit light zsh-users/zsh-completions # Completion of commands' actions

zinit light zdharma/history-search-multi-word # History search

# Plugins (End) }}}

# Variables (Start) {{{

# User defined variables
export LOCAL_BIN_PATH="$HOME/.local/bin"

# Environment variables
export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"
export LANGUAGE="en_US.UTF-8"

export EDITOR="nvim"
export VISUAL="nvim"
export MANPAGER='nvim +Man!'

export SUDO_ASKPASS="$LOCAL_BIN_PATH/sudo_pass"

# Homebrew
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_ENV_HINTS=1

# w3m
export W3M_DIR="$XDG_CONFIG_HOME/w3m"

# rclone
export RCLONE_PROGRESS=true
export RCLONE_EXCLUDE="*.DS_Store"

# GnuPG and password-store
export PASSWORD_STORE_DIR="$HOME/password-store"
export GPG_TTY=$(tty)

# Variables (End) }}}

# Alias (Start) {{{

# Aliases for changing directories
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."
alias .......="cd ../../../../../.."
alias ........="cd ../../../../../../.."

# Check if `eza` command exists and create aliases accordingly
if command -v eza >/dev/null 2>&1; then
	alias ls="eza --group-directories-first --icons --classify"
	alias tree="ls --tree --level=3 --ignore-glob 'node_modules|.git|.cache'"
elif [ "$(uname)" = "Linux" ]; then
	alias ls="ls --color=auto --classify --group-directories-first"
elif [ "$(uname)" = "Darwin" ]; then
	alias ls="ls -GF"
fi

# More aliases
alias la="ls --all"
alias lla="ll --all"
alias l1="ls -1"
alias trea="tree -a"

# Check if `nvim` command exists and create aliases accordingly
if command -v nvim >/dev/null 2>&1; then
	alias nvimt="nvim +EditTodo"
	alias nvimb="nvim +EditBookmarks"
	alias nvimr="nvim +EditReadinglist"
	alias nvimd="nvim +EditDailynote"
fi

# Check if `dust` command exists and create an alias accordingly
if command -v dust >/dev/null 2>&1; then
	alias dust="dust --reverse"
fi

# Check if `trash` command exists and create aliases accordingly
if command -v trash >/dev/null 2>&1; then
	alias dl="trash -r"
	alias rm="echo 'rm is dangerous; use dl instead. (Given args:'"
fi

# Check if `neomutt` command exists and create an alias accordingly
if command -v neomutt >/dev/null 2>&1; then
	alias mutt="cd $XDG_CACHE_HOME/neomutt && env TERM=screen-256color neomutt && cd -"
fi

# Modify `sudo` command if it exists
if command -v sudo >/dev/null 2>&1; then
	alias sudo="sudo -A"
fi

# Check if `fd` command exists and create an alias accordingly
if command -v fd >/dev/null 2>&1; then
	alias fd="fd --hidden --exclude .git/"
fi

# Alias `python` to `python3` if `python3` command exists
if command -v python3 >/dev/null 2>&1; then
	alias python="python3"
fi

# Alias `pip` to `pip3` if `pip3` command exists
if command -v pip3 >/dev/null 2>&1; then
	alias pip="pip3"
fi

# Check if `lnks` command exists and create aliases accordingly
if command -v lnks >/dev/null 2>&1; then
	lnks_dir="$HOME/docs/__bookmarks"
	alias lnks="lnks --dir $lnks_dir"
	alias lnks_chrome="lnks --dir $lnks_dir/chrome"
fi

# Platform-specific aliases for Linux
if [ "$(uname)" = "Linux" ]; then
	alias pbcopy="xsel --clipboard --input"
	alias pbpaste="xsel --clipboard --output"
	alias open="xdg-open"
fi

# alias (End) }}}

# External applications (Start) {{{

# Zoxide initialization
if command -v zoxide >/dev/null 2>&1; then
	eval "$(zoxide init --cmd c zsh)"
	zstyle :prompt:pure:git:stash show yes
fi

# External applications (End) }}}

# Options (Start) {{{

bindkey -e

# Options (End) }}}

# Path (Start) {{{

# Local variable to hold the brew path
brew_path=""

# Set brew path based on operating system
if [ "$(uname)" = "Darwin" ]; then
	brew_path="/opt/homebrew/bin/brew"
elif [ "$(uname)" = "Linux" ]; then
	brew_path="/home/linuxbrew/.linuxbrew/bin/brew"
fi

# If brew_path is executable, execute its shell environment setup
if [ -x "$brew_path" ]; then
	eval "$($brew_path shellenv)"
	export PATH="$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin:$PATH"
fi

# Create local bin directory if it does not exist
if [ ! -d "$LOCAL_BIN_PATH" ]; then
	mkdir -p "$LOCAL_BIN_PATH"
fi

# Add paths to the PATH environment variable
export PATH="$LOCAL_BIN_PATH:$PATH"
export PATH="$XDG_DATA_HOME/node_bin/node_modules/.bin:$PATH"

# Path (End) }}}
