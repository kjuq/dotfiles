set -q XDG_CONFIG_HOME; or set --export XDG_CONFIG_HOME "$HOME/.config"
set -q XDG_CACHE_HOME; or set --export XDG_CACHE_HOME "$HOME/.cache"
set -q XDG_DATA_HOME; or set --export XDG_DATA_HOME "$HOME/.local/share"
set -q XDG_STATE_HOME; or set --export XDG_STATE_HOME "$HOME/.local/state"

# Check if fisher is installed
if not functions -q fisher
    echo "========================="
    echo " Fisher is not installed"
    echo "  Execute `fisher_init`"
    echo "========================="
end

# Disable fish auto-completion
# set -g fish_autosuggestion_enabled 0

# Reset fish_user_paths
set -eU fish_user_paths

# Environment variables
set --export LC_ALL en_US.UTF-8
set --export LANG en_US.UTF-8
set --export LANGUAGE en_US.UTF-8

set --export EDITOR nvim
set --export VISUAL nvim
set --export PAGER less
set --export MANPAGER less

set --export HOMEBREW_NO_ANALYTICS 1
set --export HOMEBREW_NO_ENV_HINTS 1

# Aliases
if command --search --quiet exa
    alias ls="exa --classify --group-directories-first --icons"
    alias exat="ls --tree --level=3 --ignore-glob \"node_modules|.git|.cache\""
    alias exata="la --tree --level=3 --ignore-glob \"node_modules|.git|.cache\""
else
    alias ls="ls --color=auto --classify --group-directories-first"
end
alias la="ls --all"
alias lla="ll --all"
alias l1="ls -1"

alias dust="dust --reverse"

if command --search --quiet trash
    alias dl="trash -r"
    alias rm="echo '\'rm\' is deprecated. Use \'dl\' to move them to trash.'"
end

alias ojp="oj t -c 'python3 main.py'"
alias acsp="ojp; and acc submit main.py"
alias mutt="cd $XDG_CACHE_HOME/neomutt; and env TERM=screen-256color neomutt; cd -"

if not command --search --quiet python
    alias python="python3"
end
if not command --search --quiet pip
    alias pip="pip3"
end

alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."
alias .......="cd ../../../../../.."
alias ........="cd ../../../../../../.."

# fzf
fzf_configure_bindings --directory=\cs
set fzf_fd_opts --hidden --exclude .git # used by fzf.fish
set --export FZF_DEFAULT_COMMAND "fd --type f $fzf_fd_opts"
set --export FZF_DEFAULT_OPTS '--height 40% --layout=reverse --border'

# Zoxide initialization
if command --search --quiet zoxide
    zoxide init --cmd c fish | source
end

# GnuPG and password-store
set --export PASSWORD_STORE_DIR "$HOME/password-store"
set --export GPG_TTY (tty)
alias passpush="cd $PASSWORD_STORE_DIR; and git push; and cd -"
alias passpull="cd $PASSWORD_STORE_DIR; and git pull; and cd -"

# local bin
set --local local_bin_path "$HOME/.local/bin"
if [ ! -d "$local_bin_path" ]
	mkdir "$local_bin_path"
end
fish_add_path $local_bin_path

# OS-specific
if [ (uname) = "Darwin" ]
    eval (/opt/homebrew/bin/brew shellenv)
    fish_add_path /opt/homebrew/opt/coreutils/libexec/gnubin
    fish_add_path /opt/homebrew/opt/ruby/bin
    fish_add_path /opt/homebrew/opt/llvm/bin
    fish_add_path /opt/homebrew/opt/ncurses/bin
else if [ (uname) = "Linux" ]
	eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
    alias open="xdg-open"
    alias pbcopy="xsel --clipboard --input"
end

# vim: set filetype=fish :
