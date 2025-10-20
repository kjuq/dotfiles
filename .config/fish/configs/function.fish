function fisher_init
	# The deletion below may be unnecessary when setting up a completely new environment
	set --local fisher_completions_path "$XDG_CONFIG_HOME/fish/completions/fisher.fish"
	if [ -f $fisher_completions_path ]
		command rm $fisher_completions_path
	end
	curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source
	fisher install jorgebucaran/fisher
	fisher install patrickf1/fzf.fish
	fisher install decors/fish-ghq
	fisher install d42/fish-pip-completion
end

# To avoid bad performance by being overridden by `pkgfile`
function fish_command_not_found
	__fish_default_command_not_found_handler $argv[1]
end

function fish_greeting
end
