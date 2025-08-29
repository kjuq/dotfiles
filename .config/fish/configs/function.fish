function fisher_init
	# The deletion below may be unnecessary when setting up a completely new environment
	set --local fisher_completions_path "$XDG_CONFIG_HOME/fish/completions/fisher.fish"
	if [ -f $fisher_completions_path ]
		command rm $fisher_completions_path
	end

	curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher

	fisher install patrickf1/fzf.fish
	fisher install decors/fish-ghq
	fisher install d42/fish-pip-completion

	set --export pure_color_current_directory normal # fisher_init to take effect
end

# To avoid bad performance by being overridden by `pkgfile`
function fish_command_not_found
	__fish_default_command_not_found_handler $argv[1]
end

function fish_greeting
end

function fish_prompt
	# NOTE: Performance https://github.com/fish-shell/fish-shell/issues/7903
	set -l last_pipestatus $pipestatus
	set -lx __fish_last_status $status # Export for __fish_print_pipestatus.
	set -q fish_color_status; or set -g fish_color_status red

	# Color the prompt differently when we're root
	set -l suffix '❯'

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

	# Git branch and dirty symbol
	set --local git_vcs_prompt ''
	if not string match -q 'fuse*' -- $(df --output=fstype . | tail -n1 ) # if cwd is NOT mounted as fuse
		set git_vcs_prompt $(fish_vcs_prompt | tr -d '()')
		set --local is_git_repository (command git rev-parse --is-inside-work-tree 2>/dev/null)
		set --local is_git_dirty (
		if command git rev-list --max-count=1 HEAD -- >/dev/null 2>&1;
			not command git diff-index --ignore-submodules --cached --quiet HEAD -- >/dev/null 2>&1;
		else;
			not command git diff --staged --ignore-submodules --no-ext-diff --quiet --exit-code >/dev/null 2>&1;
		end
		or not command git diff --ignore-submodules --no-ext-diff --quiet --exit-code >/dev/null 2>&1
		or command git ls-files --others --exclude-standard --directory --no-empty-directory --error-unmatch -- ':/*' >/dev/null 2>&1
		and echo "true"
		)
		set --local git_dirty_symbol
		if test -n "$is_git_dirty" && test -n "$is_git_repository" # untracked or un-commited files
			set git_dirty_symbol '*'
		end
	end

	echo -n -s \
	$(set_color normal) $(dirs) \
	$(set_color brblack) "$git_vcs_prompt" \
	$(set_color brblack) "$git_dirty_symbol" \
	$(set_color brblack) "$user_and_hostname" \
	" $prompt_status" \
	\n $suffix " "
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
