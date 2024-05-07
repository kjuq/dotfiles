# Reset fish_user_paths
set -eU fish_user_paths

if [ (uname) = "Darwin" ]
	eval (/opt/homebrew/bin/brew shellenv)
	fish_add_path -m "$HOMEBREW_PREFIX/sbin"
	fish_add_path -m "$HOMEBREW_PREFIX/bin"
	fish_add_path "$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin"
else if [ (uname) = "Linux" ]
	eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
end

# create local bin if it not exists
if [ ! -d "$LOCAL_BIN_PATH" ]
	mkdir "$LOCAL_BIN_PATH"
end

fish_add_path "$LOCAL_BIN_PATH"
fish_add_path "$XDG_DATA_HOME/node_bin/node_modules/.bin"
