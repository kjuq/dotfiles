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
	alias Nvim="env NVIM_NO_USER_PLUGINS=1 nvim"
	alias nvimt="nvim +EditTodo"
	alias nvimb="nvim +EditBookmarks"
	alias nvimr="nvim +EditReponotes"
	alias nvimR="nvim +EditReadinglist"
	alias nvimd="nvim +EditDailynote"
end

if command --search --quiet python
	alias python='python -q'
end

if command --search --quiet git
	alias groot='cd $(git rev-parse --show-toplevel)'
end

if command --search --quiet trash
	alias dl="trash -r"
	alias rm="echo '`rm` is dangerous so use `dl` instead. (Given args:'"
end

if command --search --quiet sudo
	# `-A`: Use $SUDO_ASKPASS
	# `-E`: Preserve environment variables
	alias sudo="sudo -AE"
end

if command --search --quiet nvidia-settings
	alias nvidia-settings='nvidia-settings --config="$XDG_CONFIG_HOME"/nvidia/settings'
end

if command --search --quiet fd
	alias fd="fd --hidden"
end

if command --search --quiet w3m
	alias w3m='env TERM=xterm-256color w3m'
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
