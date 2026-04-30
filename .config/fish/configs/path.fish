if [ -n "$_KJUQ_FISH_CONFIG_LOADED" ]
	return
end

set -l brew_path /opt/homebrew/bin/brew # Only for MacOS
if [ -e $brew_path ]
	eval ($brew_path shellenv)
	fish_add_path "$HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin"
end

if command --search --quiet go
	fish_add_path "$GOPATH/bin:$PATH"
end

if command --search --quiet npm
	fish_add_path "$(npm config get prefix)/bin"
end

# Use builtin command `set` instead of `fish_add_path` because it is slow
fish_add_path "$HOME/.local/bin"
fish_add_path "$HOME/kjuq/bin"
