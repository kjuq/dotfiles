# Reset fish_user_paths
set -eU fish_user_paths

set -l brew_path "/opt/homebrew/bin/brew" # Only for MacOS
if [ -e $brew_path ]
	set --export PATH "$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin:$PATH"
	eval ($brew_path shellenv)
end

# Use builtin command `set` instead of `fish_add_path` because it is slow
set --export PATH "$HOME/.local/bin:$PATH"
set --export PATH "$HOME/.local/bin_kjuq:$PATH"
