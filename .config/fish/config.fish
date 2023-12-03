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

if command --search --quiet dust
    alias dust="dust --reverse"
end

if command --search --quiet trash
    alias dl="trash -r"
    alias rm="echo '\'rm\' is deprecated. Use \'dl\' to move them to trash.'"
end

alias oj-test-python="oj test -c 'python3 main.py'"
alias oj-submit-python="oj-test-python; and acc submit main.py"

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

# local bin
set --local local_bin_path "$HOME/.local/bin"
if [ ! -d "$local_bin_path" ]
	mkdir "$local_bin_path"
end
fish_add_path "$local_bin_path"

fish_add_path "$HOME/node_modules/.bin"

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
    alias pbpaste="xsel --clipboard --output"

	set --export BROWSER "/usr/bin/vivaldi"
end

# functions

function fisher_init
    # The deletion below may be unnecessary when setting up a completely new environment
    set --local fisher_completions_path "$XDG_CONFIG_HOME/fish/completions/fisher.fish"
    if [ -f $fisher_completions_path ]
        command rm $fisher_completions_path
    end

    curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source; \
        and fisher install jorgebucaran/fisher

    fisher install rafaelrinaldi/pure
    fisher install decors/fish-colored-man
    fisher install kjuq/fish-pip-completion
    fisher install PatrickF1/fzf.fish

    set --export pure_color_current_directory normal # fisher_init to take effect
end

function nvimcopy --description="Open nvim for copying text"
	set --local tmp "/tmp/clip_tmp_nae18aA6ARaiOF"
	nvim -c "startinsert" "$tmp"; and [ -e "$tmp" ]; and head -c -1 "$tmp" | pbcopy; and command rm "$tmp"
end

function po --description='copy password from password-store (OSC52 compatible)'
	command pass show -c "$argv"; and pbpaste | osc52
end

function acw --description='Usage: acw abc290 a'
    if test (count $argv) -ne 2
        echo "Not enough arguments. Usage: acw abc290 a"
        return 1
    end
    set --local sed_str          "s/\\\leq/<=/g;"
    set --local sed_str $sed_str "s/\\\geq/>=/g;"
    set --local sed_str $sed_str "s/\\\dots/.../g;"
    set --local sed_str $sed_str "s/\\\ldots/.../g;"
    w3m "https://atcoder.jp/contests/$argv[1]/tasks/$argv[1]_$argv[2]" | sed "$sed_str" | less
end

function cplus --description="compile and execute a cpp file"
	set --local output "/tmp/cplus_output"

	command g++ \
		-std=c++20 \
		-Wall \
		-Wextra \
		# Detect memory-related diagnostics
		-fsanitize=address \
		# GNU's libstdc++ debug mode
		-D_GLIBCXX_DEBUG \
		# Clang's libc++ debug mode
		-D_LIBCPP_ENABLE_DEBUG_MODE \
		-I"$HOMEBREW_PREFIX/include/" \
		-o "$output" \
		"$argv"

	if [ $status = 0 ]
		"$output"
	end
end

# po completion

set -l PROG 'po'

function __fish_pass_get_prefix
    if set -q PASSWORD_STORE_DIR
        realpath -- "$PASSWORD_STORE_DIR"
    else
        echo "$HOME/.password-store"
    end
end

function __fish_pass_needs_command
    [ (count (commandline -opc)) -eq 1 ]
end

function __fish_pass_uses_command
    set -l cmd (commandline -opc)
    if [ (count $cmd) -gt 1 ]
        if [ $argv[1] = $cmd[2] ]
            return 0
        end
    end
    return 1
end

function __fish_pass_print
    set -l ext $argv[1]
    set -l strip $argv[2]
    set -l prefix (__fish_pass_get_prefix)
    set -l matches $prefix/**$ext
    printf '%s\n' $matches | sed "s#$prefix/\(.*\)$strip#\1#"
end

function __fish_pass_print_entries
    __fish_pass_print ".gpg" ".gpg"
end

complete -c $PROG -f -n '__fish_pass_needs_command' -s c -l clip -d 'Put password in clipboard'
complete -c $PROG -f -n '__fish_pass_needs_command' -a "(__fish_pass_print_entries)"
complete -c $PROG -f -n '__fish_pass_uses_command -c' -a "(__fish_pass_print_entries)"
complete -c $PROG -f -n '__fish_pass_uses_command --clip' -a "(__fish_pass_print_entries)"

# po completion END
