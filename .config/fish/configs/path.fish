# Reset fish_user_paths
set -eU fish_user_paths

if [ (uname) = "Darwin" ]
    eval (/opt/homebrew/bin/brew shellenv)
    fish_add_path "$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin"
else if [ (uname) = "Linux" ]
	eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
end

# create local bin if it not exists
set --local local_bin_path "$HOME/.local/bin"
if [ ! -d "$local_bin_path" ]
	mkdir "$local_bin_path"
end

fish_add_path "$local_bin_path"
fish_add_path "$XDG_DATA_HOME/node_bin/node_modules/.bin"
