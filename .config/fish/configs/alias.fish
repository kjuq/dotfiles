alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."
alias .......="cd ../../../../../.."
alias ........="cd ../../../../../../.."

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
    alias rm="echo '`rm` is dangerous so use `dl` instead.'"
end

if command --search --quiet neomutt
    alias mutt="cd $XDG_CACHE_HOME/neomutt; and env TERM=screen-256color neomutt; cd -"
end

alias python="python3"
alias pip="pip3"

alias cpl="c++ -std=c++20 -Wall -Wextra -fsanitize=address -D_GLIBCXX_DEBUG -D_LIBCPP_ENABLE_DEBUG_MODE -I$HOMEBREW_PREFIX/include/"

if [ (uname) = "Linux" ]
    alias open="xdg-open"
    alias pbcopy="xsel --clipboard --input"
    alias pbpaste="xsel --clipboard --output"
end
