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

if [ ! -d "$LOCAL_BIN_PATH" ]
	mkdir "$LOCAL_BIN_PATH"
end
fish_add_path "$LOCAL_BIN_PATH"
