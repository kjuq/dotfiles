if command --search --quiet fzf_configure_bindings
	fzf_configure_bindings --directory=\cs --variables=\ev
end

if command --search --quiet zoxide
	zoxide init --cmd c fish | source
end

# if command --search --quiet direnv
# 	direnv hook fish | source
# 	set --export DIRENV_LOG_FORMAT ""
# end
#
# if command --search --quiet mise
# 	mise activate fish | source
# end
