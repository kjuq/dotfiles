if [ -z "$_KJUQ_FISH_CONFIG_LOADED" ]
	# Fish prompt
	set --export __fish_git_prompt_showdirtystate true
	set --export __fish_git_prompt_showstashstate true
	set --export __fish_git_prompt_char_stateseparator ''
end

function fish_prompt
	# NOTE: Performance https://github.com/fish-shell/fish-shell/issues/7903
	set -l last_pipestatus $pipestatus
	set -lx __fish_last_status $status # Export for __fish_print_pipestatus.
	set -q fish_color_status; or set -g fish_color_status red

	# Write pipestatus
	# If the status was carried over (if no command is issued or if `set` leaves the status untouched), don't bold it.
	set -l bold_flag --bold
	set -q __fish_prompt_status_generation; or set -g __fish_prompt_status_generation $status_generation
	[ $__fish_prompt_status_generation = $status_generation ]; or set bold_flag
	set __fish_prompt_status_generation $status_generation
	set -l prompt_status (__fish_print_pipestatus "[" "]" "|" "$(set_color $fish_color_status)" "$(set_color $bold_flag $fish_color_status)" $last_pipestatus)

	set -l user_and_hostname ''
	if test "$SSH_CONNECTION" != ''
		set user_and_hostname " $USER@$hostname"
	end

	echo -n -s \
		$(set_color normal) $(dirs) \
		$(set_color brblack) "$(fish_vcs_prompt | tr -d '()')" \
		$(set_color brblack) "$user_and_hostname" \
		" $prompt_status" \
		\n \
		'❯ '
end

set --global _kjuq_fresh_session true
function _pure_prompt_new_line --on-event fish_prompt --description "Do not add a line break to a brand new session"
	set --local new_line ''
	if test "$_kjuq_fresh_session" = false
		set new_line "\n"
	end
	set --local clear_line "\r\033[K"
	echo -e -n -s "$clear_line" "$new_line"
	set _kjuq_fresh_session false
end
