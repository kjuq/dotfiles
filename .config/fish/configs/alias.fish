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
else if [ (uname) = "Linux" ]
    alias ls="ls --color=auto --classify --group-directories-first"
else if [ (uname) = "Darwin" ]
    alias ls="ls -GF"
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

if [ (uname) = "Linux" ]
    alias open="xdg-open"
end
