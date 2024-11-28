#!/usr/bin/env bash

tmux list-panes -F '#{pane_active} #{pane_pid}' | grep --regexp '^1 ' | cut -d ' ' -f2 | xargs -I {} ps --ppid {} --format comm | tail -n1
