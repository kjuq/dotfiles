function fisher_init
	# The deletion below may be unnecessary when setting up a completely new environment
	set --local fisher_completions_path "$XDG_CONFIG_HOME/fish/completions/fisher.fish"
	if [ -f $fisher_completions_path ]
		command rm $fisher_completions_path
	end

	curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher

	fisher update

	set --export pure_color_current_directory normal # fisher_init to take effect
end

# To avoid bad performance by being overridden by `pkgfile`
function fish_command_not_found
	__fish_default_command_not_found_handler $argv[1]
end

# Hooks
# This hook makes every outputs a bit slower (6.98ms -> 9.75ms) but it's smaller than 1 frame (1/60s)
function preexec_esckey --on-event fish_preexec
	if not echo "$argv[1]" | grep --extended-regexp --word-regexp --quiet '(w3m|bat|less)'
		return
	end
	if [ ! -e $KJUQ_TMUX_ESCAPE ]
		touch $KJUQ_TMUX_ESCAPE
	end
	# increment
	echo $(math $(cat $KJUQ_TMUX_ESCAPE) + 1) > $KJUQ_TMUX_ESCAPE
end
function postexec_esckey --on-event fish_postexec
	if [ ! -e "$KJUQ_TMUX_ESCAPE" ] || not echo "$argv[1]" | grep --extended-regexp --word-regexp --quiet '(w3m|bat|less)'
		return
	end
	# decrement
	echo $(math $(cat $KJUQ_TMUX_ESCAPE) - 1) > $KJUQ_TMUX_ESCAPE
	if [ $(cat $KJUQ_TMUX_ESCAPE) -le 0 ]
		command rm "$KJUQ_TMUX_ESCAPE" # rm is aliased
	end
end
