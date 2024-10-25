# fzf
fzf_configure_bindings --directory=\cs --variables=\ev
set fzf_fd_opts --hidden --exclude .git # used by fzf.fish
set --export FZF_DEFAULT_COMMAND "fd --type f $fzf_fd_opts"
set --export FZF_DEFAULT_OPTS '--height 40% --layout=reverse --border'

# Zoxide initialization
if command --search --quiet zoxide
	zoxide init --cmd c fish | source
end

# direnv
if command --search --quiet direnv
	direnv hook fish | source
	set --export DIRENV_LOG_FORMAT ""
end

# mise
if command --search --quiet mise
	mise activate fish | source
end
