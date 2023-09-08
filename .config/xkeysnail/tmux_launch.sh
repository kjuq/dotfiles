#!/usr/bin/bash
tmux new -d -s xkeysnail_session

if [[ -z "$USER_PASSWORD" ]]; then
	echo "Must provide USER_PASSWORD in environment" 1>&2
	tmux kill-session -t xkeysnail_session
	exit 1
fi

tmux send -t xkeysnail_session "sh ~/.xkeysnail/root_launch.sh" ENTER $USER_PASSWORD ENTER
tmux

