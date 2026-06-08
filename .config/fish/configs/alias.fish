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
	function ghf
		set --local repo "$(ghq list | fzf)"
		if [ ! $repo = '' ]
			cd "$(ghq root)/$repo"
		end
	end
end

if command --search --quiet fzf
	function gwf
		if not git rev-parse --is-inside-work-tree > /dev/null 2>&1
			echo "Not a git repo"
			return 1
		end
		set --local repo $(git worktree list | fzf | cut -d ' ' -f 1)
		if [ ! $repo = '' ]
			cd $repo
		end
	end
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
