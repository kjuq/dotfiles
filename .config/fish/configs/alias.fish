alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."
alias .......="cd ../../../../../.."
alias ........="cd ../../../../../../.."

if command --search --quiet eza
	alias ls="eza --group-directories-first --icons --classify"
	alias tree="ls --tree --level=3 --ignore-glob \"node_modules|.git|.cache\""
else if [ (uname) = "Linux" ]
	alias ls="ls --color=auto --classify --group-directories-first"
else if [ (uname) = "Darwin" ]
	alias ls="ls -GF"
end
alias la="ls --all"
alias lla="ll --all"
alias l1="ls -1"
alias trea="tree -a"

if command --search --quiet nvim
	alias nvimt="nvim +EditTodo"
	alias nvimb="nvim +EditBookmarks"
	alias nvimr="nvim +EditReadinglist"
	alias nvimd="nvim +EditDailynote"
end

if command --search --quiet dust
	alias dust="dust --reverse"
end

if command --search --quiet trash
	alias dl="trash -r"
	alias rm="echo '`rm` is dangerous so use `dl` instead. (Given args:'"
end

if command --search --quiet neomutt
	alias mutt="cd $XDG_CACHE_HOME/neomutt; and env TERM=screen-256color neomutt; cd -"
end

if command --search --quiet sudo
	alias sudo="sudo -A"
end

if command --search --quiet fd
	alias fd="fd --hidden --exclude .git/"
end

if command --search --quiet python3
	alias python="python3"
end

if command --search --quiet pip3
	alias pip="pip3"
end

if command --search --quiet lnks
	set --local lnks_dir "$HOME/docs/__bookmarks"
	alias lnks="lnks --dir $lnks_dir"
	alias lnks_chrome="lnks --dir $lnks_dir/chrome"
end

if [ (uname) = "Linux" ]
	alias pbcopy="xsel --clipboard --input"
	alias pbpaste="xsel --clipboard --output"
	alias open="xdg-open"
end
