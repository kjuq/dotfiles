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

if command --search --quiet eza
	function ls --wraps='eza --group-directories-first --icons --classify'
		eza --group-directories-first --icons --classify
	end
	function tree --wraps='ls --tree --level=3 --ignore-glob "node_modules|.git|.cache"'
		ls --tree --level=3 --ignore-glob \"node_modules|.git|.cache\"
	end
else if [ (uname) = "Linux" ]
	function ls --wraps='command ls --color=auto --classify --group-directories-first'
		command ls --color=auto --classify --group-directories-first
	end
else if [ (uname) = "Darwin" ]
	function ls --wraps='ls -GF'
		command ls -GF
	end
end

function la --wraps='ls --all'
	ls --all
end
function lla --wraps='ll --all'
	ll --all
end
function l1 --wraps='ls -1'
	ls -1
end
function trea --wraps='tree -a'
	tree -a
end

if command --search --quiet nvim
	function Nvim --wraps='env NVIM_NO_USER_PLUGINS=1 nvim'
		env NVIM_NO_USER_PLUGINS=1 nvim
	end
	function nvimt --wraps='nvim +EditTodo'
		nvim +EditTodo
	end
	function nvimb --wraps='nvim +EditBookmarks'
		nvim +EditBookmarks
	end
	function nvimr --wraps='nvim +EditReponotes'
		nvim +EditReponotes
	end
	function nvimR --wraps='nvim +EditReadinglist'
		nvim +EditReadinglist
	end
	function nvimd --wraps='nvim +EditDailynote'
		nvim +EditDailynote
	end
end

if command --search --quiet python
	function python --wraps='python -q'
		python -q
	end
end
if command --search --quiet git
	function groot --wraps='cd $(git rev-parse --show-toplevel)'
		cd $(git rev-parse --show-toplevel)
	end
end
if command --search --quiet trash
	function dl --wraps='trash -r'
		trash -r
	end
	function rm --wraps="echo '`rm` is dangerous so use `dl` instead. (Given args:'"
		echo '`rm` is dangerous so use `dl` instead. (Given args:'
	end
end
if command --search --quiet sudo
	function sudo --wraps='sudo -AE'
		sudo -AE
	end
end
if command --search --quiet nvidia-settings
	function nvidia-settings --wraps='nvidia-settings --config="$XDG_CONFIG_HOME"/nvidia/settings'
		nvidia-settings --config="$XDG_CONFIG_HOME"/nvidia/settings
	end
end
if command --search --quiet fd
	function fd --wraps='fd --hidden'
		fd --hidden
	end
end
if command --search --quiet w3m
	function w3m --wraps='env TERM=xterm-256color w3m'
		env TERM=xterm-256color w3m
	end
end

if [ (uname) = "Linux" ]
	function pbcopy --wraps='xsel --clipboard --input'
		xsel --clipboard --input
	end
	function pbpaste --wraps='xsel --clipboard --output'
		xsel --clipboard --output
	end
	function open --wraps='xdg-open'
		xdg-open
	end
end
