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
	ls --all $argv
end
function lla --wraps='ll --all'
	ll --all $argv
end
function l1 --wraps='ls -1'
	ls -1 $argv
end
function trea --wraps='tree -a'
	tree -a $argv
end

if command --search --quiet eza
	function ls --wraps='eza --group-directories-first --icons --classify'
		command eza --group-directories-first --icons --classify $argv
	end
	function tree --wraps='ls --tree --level=3 --ignore-glob "node_modules|.git|.cache"'
		ls --tree --level=3 --ignore-glob \"node_modules|.git|.cache\" $argv
	end
else if [ (uname) = "Linux" ]
	function ls --wraps='command ls --color=auto --classify --group-directories-first'
		command ls --color=auto --classify --group-directories-first $argv
	end
else if [ (uname) = "Darwin" ]
	function ls --wraps='ls -GF'
		command ls -GF $argv
	end
end

if command --search --quiet nvim
	function Nvim --wraps='env NVIM_NO_USER_PLUGINS=1 nvim'
		env NVIM_NO_USER_PLUGINS=1 nvim $argv
	end
	function nvimt --wraps='nvim +EditTodo'
		nvim +EditTodo $argv
	end
	function nvimb --wraps='nvim +EditBookmarks'
		nvim +EditBookmarks $argv
	end
	function nvimr --wraps='nvim +EditReponotes'
		nvim +EditReponotes $argv
	end
	function nvimR --wraps='nvim +EditReadinglist'
		nvim +EditReadinglist $argv
	end
	function nvimd --wraps='nvim +EditDailynote'
		nvim +EditDailynote $argv
	end
end

if command --search --quiet python
	function python --wraps='python -q'
		command python -q $argv
	end
end

if command --search --quiet git
	function groot --wraps='cd $(git rev-parse --show-toplevel)'
		command cd $(git rev-parse --show-toplevel) $argv
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

if command --search --quiet sudo
	function sudo --wraps='sudo -AE'
		command sudo -AE $argv
	end
end

if command --search --quiet nvidia-settings
	function nvidia-settings --wraps='nvidia-settings --config="$XDG_CONFIG_HOME"/nvidia/settings'
		command nvidia-settings --config="$XDG_CONFIG_HOME"/nvidia/settings $argv
	end
end

if command --search --quiet fd
	function fd --wraps='fd --hidden'
		command fd --hidden $argv
	end
end

if command --search --quiet w3m
	function w3m --wraps='env TERM=xterm-256color w3m'
		env TERM=xterm-256color command w3m $argv
	end
end

if [ (uname) = "Linux" ]
	function pbcopy --wraps='xsel --clipboard --input'
		command xsel --clipboard --input $argv
	end
	function pbpaste --wraps='xsel --clipboard --output'
		command xsel --clipboard --output $argv
	end
	function open --wraps='xdg-open'
		command xdg-open $argv
	end
end
