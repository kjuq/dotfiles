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

function fish_greeting
end

function fish_prompt
	set -l last_pipestatus $pipestatus
	set -lx __fish_last_status $status # Export for __fish_print_pipestatus.
	set -q fish_color_status; or set -g fish_color_status red

	# Color the prompt differently when we're root
	set fish_color_cwd normal
	set -l color_cwd $fish_color_cwd
	set -l suffix '❯'
	if functions -q fish_is_root_user; and fish_is_root_user
		if set -q fish_color_cwd_root
			set color_cwd $fish_color_cwd_root
		end
		set suffix '#'
	end

	# Write pipestatus
	# If the status was carried over (if no command is issued or if `set` leaves the status untouched), don't bold it.
	set -l bold_flag --bold
	set -q __fish_prompt_status_generation; or set -g __fish_prompt_status_generation $status_generation
	if test $__fish_prompt_status_generation = $status_generation
		set bold_flag
	end
	set __fish_prompt_status_generation $status_generation
	set -l status_color (set_color $fish_color_status)
	set -l statusb_color (set_color $bold_flag $fish_color_status)
	set -l prompt_status (__fish_print_pipestatus "[" "]" "|" "$status_color" "$statusb_color" $last_pipestatus)

	set -l user_and_hostname ''
	if test "$SSH_CONNECTION" != ''
		set user_and_hostname " $USER@$hostname"
	end

	echo -n -s \
		$(set_color $color_cwd) (dirs) \
		$(set_color brblack) $(fish_vcs_prompt | tr -d '()') \
		$(set_color brblack) "$user_and_hostname" \
		" "$prompt_status \
		\n $suffix " "
end

set --global _kjuq_fresh_session true
function _pure_prompt_new_line \
	--description "Do not add a line break to a brand new session" \
	--on-event fish_prompt

	set --local new_line ''
	if test "$_kjuq_fresh_session" = false
		set new_line "\n"
	end

	set --local clear_line "\r\033[K"
	echo -e -n -s "$clear_line" "$new_line"
	set _kjuq_fresh_session false
end
