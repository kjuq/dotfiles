#!/usr/bin/env bash

tmuxscripts=$XDG_CONFIG_HOME/tmux/scripts
proc=$("$tmuxscripts"/get_active_proc.sh)

if [ "$proc" = 'bat' ] || [ "$proc" = 'less' ] || [ "$proc" = 'neomutt' ]; then
	echo -n 'F11'
elif [ "$proc" = 'w3m' ]; then
	echo -n 'C-g'
else
	echo -n 'Escape'
fi
