# Reset fish_user_paths
set -eU fish_user_paths

set -l brew_path

if [ (uname) = "Darwin" ]
	set brew_path "/opt/homebrew/bin/brew"
	fish_add_path "$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin"
else if [ (uname) = "Linux" ]
	set brew_path "/home/linuxbrew/.linuxbrew/bin/brew"
end

if [ -x $brew_path ]
	eval ($brew_path shellenv)
end

fish_add_path "$HOME/.local/bin"
fish_add_path "$HOME/.local/bin_kjuq"
