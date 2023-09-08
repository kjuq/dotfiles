# set XDG_CONFIG_HOME if it is not set
set -q XDG_CONFIG_HOME; or set --export XDG_CONFIG_HOME ~/.config

# fisher auto installation
if not functions -q fisher
    echo "# Fisher is not installed. #"
    echo "# Execute fisher_init. #"
end

# import local settings
if [ -f $XDG_CONFIG_HOME/fish/local_settings.fish ]
    source $XDG_CONFIG_HOME/fish/local_settings.fish
end

# disable fish auto-completion
set -g fish_autosuggestion_enabled 0

# reset fish_user_paths
set -eU fish_user_paths

# zoxide initialization
if command --search --quiet zoxide
    zoxide init --cmd c fish | source
end

# settings for Linux
if [ (uname) = "Linux" ]
    alias open="xdg-open"
    alias pbcopy="xsel --clipboard --input"
end

# settings for MacOS
if [ (uname) = "Darwin" ]
    # paths on M1 environment
    eval (/opt/homebrew/bin/brew shellenv)
    fish_add_path /opt/homebrew/opt/coreutils/libexec/gnubin
    fish_add_path /opt/homebrew/opt/ruby/bin
    fish_add_path /opt/homebrew/opt/llvm/bin

    # environment variables
    set --export HOMEBREW_NO_ANALYTICS 1

    set --export LC_ALL en_US.UTF-8
    set --export LANG en_US.UTF-8
    set --export LANGUAGE en_US.UTF-8

    set --export EDITOR nvim
    set --export VISUAL nvim

    # aliases
    if command --search --quiet exa
        alias ls="exa --classify --group-directories-first"
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

    alias cplus="g++ -std=c++14 -Wall -Wextra -Wno-unused-const-variable -g -fsanitize=address -D_GLIBCXX_DEBUG -I/opt/homebrew/include/"
    alias ojp="oj t -c 'python3 main.py'"
    alias acsp="ojp; and acc submit main.py"
end

# python -> python3 (it doesn't overwrite if `python` already exists)
if not command --search --quiet python
    alias python="python3"
end
if not command --search --quiet pip
    alias pip="pip3"
end

function acw --description='Usage: acw abc290 a'
    if test (count $argv) -ne 2
        echo "Not enough arguments. Usage: acw abc290 a"
        return 1
    end
    set --local sed_str          "s/\\\le/<=/g;"
    set --local sed_str $sed_str "s/\\\ge/>=/g;"
    set --local sed_str $sed_str "s/\\\dots/.../g;"
    set --local sed_str $sed_str "s/\\\ldots/.../g;"
    w3m "https://atcoder.jp/contests/$argv[1]/tasks/$argv[1]_$argv[2]" | sed "$sed_str" | less
end

function fisher_init
        # The deletion below may be unnecessary when setting up a completely new environment
    set --local fisher_completions_path "$XDG_CONFIG_HOME/fish/local_settings.fish"
    if [ -f $fisher_completions_path ]
        command rm $fisher_completions_path
    end

    curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source; \
        and fisher install jorgebucaran/fisher

    fisher install rafaelrinaldi/pure
    fisher install decors/fish-colored-man
    fisher install kjuq/pure-iceberg
    fisher install kjuq/color-tomorrow-night
    fisher install kjuq/fish-pip-completion
end

# vim: set filetype=fish :




