alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."
alias .......="cd ../../../../../.."
alias ........="cd ../../../../../../.."

if command --search --quiet eza
    alias ls="eza --classify --group-directories-first --icons"
    alias ezat="ls --tree --level=3 --ignore-glob \"node_modules|.git|.cache\""
    alias ezata="la --tree --level=3 --ignore-glob \"node_modules|.git|.cache\""
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
    alias rm="echo '`rm` is dangerous so use `dl` instead.'"
end

if command --search --quiet neomutt
    alias mutt="cd $XDG_CACHE_HOME/neomutt; and env TERM=screen-256color neomutt; cd -"
end

alias python="python3"
alias pip="pip3"

alias cpl="c++ -std=c++23 -Wall -Wextra -fsanitize=address -D_GLIBCXX_DEBUG -D_LIBCPP_ENABLE_DEBUG_MODE -I$HOMEBREW_PREFIX/include/"

if [ (uname) = "Linux" ]
    alias open="xdg-open"
    alias pbcopy="xsel --clipboard --input"
    alias pbpaste="xsel --clipboard --output"
else if [ (uname) = "Darwin" ]
    set --local cpp "g++-13"
    set --local c "gcc-13"
    if command --search --quiet "$cpp"
        alias g++="$cpp"
        alias c++="$cpp"
    end
    if command --search --quiet "$c"
        alias gcc="$c"
    end
end
