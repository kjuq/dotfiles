bind \cd delete-char # prevent accidentally quit

# To avoid bad performance by being overridden by `pkgfile`
function fish_command_not_found
	__fish_default_command_not_found_handler $argv[1]
end

function fish_greeting
end

# pass-through right click
if status is-interactive; and set -q HERDR_PANE_ID HERDR_BIN_PATH
	$HERDR_BIN_PATH pane input --current --right-click pane </dev/null >/dev/null 2>&1 &
	disown $last_pid
end

functions --erase __fish_enable_focus
functions --erase __fish_disable_focus
functions --erase __fish_enable_bracketed_paste
functions --erase __fish_disable_bracketed_paste
