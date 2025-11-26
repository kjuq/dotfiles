bind \cd delete-char # prevent accidentally quit

# To avoid bad performance by being overridden by `pkgfile`
function fish_command_not_found
	__fish_default_command_not_found_handler $argv[1]
end

function fish_greeting
end

functions --erase __fish_enable_focus
functions --erase __fish_disable_focus
functions --erase __fish_enable_bracketed_paste
functions --erase __fish_disable_bracketed_paste
