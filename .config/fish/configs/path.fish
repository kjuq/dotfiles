# `$XDG_DATA_HOME/npm` is `prefix` in `$NPM_CONFIG_USERCONFIG` (`npm config get prefix` is slow)
set -l paths "$HOME/.local/bin"
set --append paths "$HOME/kjuq/bin"
set --append paths "$XDG_DATA_HOME/npm/bin"
set --append paths "$GOPATH/bin"

set -l brew_path /opt/homebrew/bin/brew # Only for MacOS
if [ -e $brew_path ]
	# `brew shellenv` is slow, so cache its output (remove the cache to regenerate it)
	set -l cache "$XDG_CACHE_HOME/fish/brew_shellenv.fish"
	if not [ -f "$cache" ]
		mkdir -p (path dirname "$cache")
		$brew_path shellenv fish > "$cache"; or rm -f "$cache"
	end
	source "$cache"
	set --append paths "$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin"
end

if [ "$fish_user_paths" != "$paths" ]
	set --universal fish_user_paths $paths
end
