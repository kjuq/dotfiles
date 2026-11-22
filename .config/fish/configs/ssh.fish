if [ -z "$SSH_AUTH_SOCK" ] && [ -z "$SSH_AGENT_PID" ]
	eval "$(ssh-agent -c)"
end
