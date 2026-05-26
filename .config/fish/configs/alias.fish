alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../..'
alias ......='cd ../../../..'
alias .......='cd ../../../../..'

alias la='ls --almost-all'
alias lla='ll --almost-all'

alias ls='ls --color=auto --classify --group-directories-first'
if [ "$(uname)" = 'Darwin' ] && not command --search --quiet gls
	alias ls='ls -GF'
end

if command --search --quiet nvim
	alias Nvim='env KJUQ_NVIM_NO_EXT_PLUGINS=1 nvim'
	alias nvimt='nvim $KJUQ_DOCS/__index.md'
	alias nvimd='nvim +EditReponotes'
	alias nvimd='nvim +EditDailynote'
end

if command --search --quiet ghq
	alias ghf='set --local repo "$(ghq list | fzf)" && cd "$(ghq root)/$repo"'
end

if command --search --quiet git-wt && command --search --quiet fzf
	alias gwf='git rev-parse --is-inside-work-tree > /dev/null 2>&1; and cd $(git-wt | fzf --header-lines=1 | awk \'{if ($1 == "*") print $2; else print $1}\'); or echo "Not a git repo"'
end

if command --search --quiet trash
	switch $(uname)
	case Linux
		alias dl='trash -r'
	case Darwin
		alias dl='trash'
	end
	alias rm='echo "`rm` is dangerous so use `dl` instead."'
end

if command --search --quiet w3m
	alias w3m='env TERM=xterm-256color command w3m'
end
