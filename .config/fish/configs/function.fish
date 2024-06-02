function fisher_init
	# The deletion below may be unnecessary when setting up a completely new environment
	set --local fisher_completions_path "$XDG_CONFIG_HOME/fish/completions/fisher.fish"
	if [ -f $fisher_completions_path ]
		command rm $fisher_completions_path
	end

	curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source; \
		and fisher install jorgebucaran/fisher

	fisher install rafaelrinaldi/pure
	fisher install decors/fish-colored-man
	fisher install kjuq/fish-pip-completion
	fisher install PatrickF1/fzf.fish

	set --export pure_color_current_directory normal # fisher_init to take effect
end
