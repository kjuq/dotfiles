alias ...='../../..'
alias ....='../../../..'
alias .....='../../../..'
alias ......='../../../../..'
alias .......='../../../../../..'

alias la='ls --almost-all'
alias lla='ll --almost-all'

switch $(uname)
case Linux
	alias ls='ls --color=auto --classify --group-directories-first'
case Darwin
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

if command --search --quiet trash
	alias dl='trash -r'
	alias rm='echo "`rm` is dangerous so use `dl` instead."'
end

if command --search --quiet w3m
	alias w3m='env TERM=xterm-256color command w3m'
end
