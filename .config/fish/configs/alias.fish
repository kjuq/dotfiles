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
    alias rm="echo '\'rm\' is deprecated. Use \'dl\' to move them to trash.'"
end

if command --search --quiet neomutt
    alias mutt="cd $XDG_CACHE_HOME/neomutt; and env TERM=screen-256color neomutt; cd -"
end

if command --search --quiet oj
    alias oj-test-python="oj test -c 'python3 main.py'"
    alias oj-submit-python="oj-test-python; and acc submit main.py"
end

if not command --search --quiet python
    alias python="python3"
end
if not command --search --quiet pip
    alias pip="pip3"
end

if [ (uname) = "Linux" ]
    alias open="xdg-open"
    alias pbcopy="xsel --clipboard --input"
    alias pbpaste="xsel --clipboard --output"
end
