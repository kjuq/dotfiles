# Environment variables
set --export LC_ALL en_US.UTF-8
set --export LANG en_US.UTF-8
set --export LANGUAGE en_US.UTF-8

set --export EDITOR nvim
set --export VISUAL nvim
set --export PAGER less
set --export MANPAGER less

# Homebrew
set --export HOMEBREW_NO_ANALYTICS 1
set --export HOMEBREW_NO_ENV_HINTS 1

# GnuPG and password-store
set --export PASSWORD_STORE_DIR "$HOME/password-store"
set --export GPG_TTY (tty)

if [ (uname) = "Linux" ]
	set --export BROWSER "/usr/bin/vivaldi"
end
