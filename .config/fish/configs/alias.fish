function ... --wraps='cd ../..'
	cd ../..
end
function .... --wraps='cd ../../..'
	cd ../../..
end
function ..... --wraps='cd ../../../..'
	cd ../../../..
end
function ...... --wraps='cd ../../../../..'
	cd ../../../../..
end
function ....... --wraps='cd ../../../../../..'
	cd ../../../../../..
end
function ........ --wraps='cd ../../../../../../..'
	cd ../../../../../../..
end

function la --wraps='ls --all'
	ls --almost-all $argv
end
function lla --wraps='ll --all'
	ll --almost-all $argv
end
function l1 --wraps='ls -1'
	ls -1 $argv
end

switch $(uname)
case Linux
	function ls
		command ls --color=auto --classify --group-directories-first $argv
	end
case Darwin
	function ls
		ls -GF $argv
	end
end

if command --search --quiet nvim
	function Nvim --wraps='env KJUQ_NVIM_NO_EXT_PLUGINS=1 nvim'
		env KJUQ_NVIM_NO_EXT_PLUGINS=1 nvim $argv
	end
	function nvimt --wraps='nvim +EditDashboard'
		nvim +EditDashboard $argv
	end
	function nvimr --wraps='nvim +EditReponotes'
		nvim +EditReponotes $argv
	end
	function nvimd --wraps='nvim +EditDailynote'
		nvim +EditDailynote $argv
	end
end

if command --search --quiet ghq
	function ghf
		set --local repo "$(ghq list | fzf)" && cd "$(ghq root)/$repo"
	end
end

if command --search --quiet trash
	function dl --wraps='trash -r'
		command trash -r $argv
	end
	function rm --wraps="echo '`rm` is dangerous so use `dl` instead. (Given args:'"
		command echo '`rm` is dangerous so use `dl` instead. (Given args:' $argv
	end
end

if command --search --quiet w3m
	function w3m --wraps='env TERM=xterm-256color w3m'
		env TERM=xterm-256color command w3m $argv
	end
end
