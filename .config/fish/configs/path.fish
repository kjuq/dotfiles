# Reset fish_user_paths
set -eU fish_user_paths

if [ (uname) = "Darwin" ]
	set -l brew_path "/opt/homebrew/bin/brew"
	fish_add_path "$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin"
	eval ($brew_path shellenv)
end

fish_add_path "$HOME/.local/bin"
fish_add_path "$HOME/.local/bin_kjuq"
