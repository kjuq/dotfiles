#!/usr/bin/env bash

set -eu

limit=2000
file="/tmp/tmux_buffers/$(date +"%Y-%m-%d_%H-%M-%S_%3N")"

mkdir --parents "$(dirname "$file")"

# Removing trailing blank lines (https://stackoverflow.com/questions/7359527#44850844)
tmux capture-pane -p -S -$limit | sed -e :a -e '/^\n*$/{$d;N;};/\n$/ba' > "$file"

tmux new-window -t 0 nvim +"normal! GG" +"set laststatus=0" +"set filetype=tmuxbuf" +"set nomodifiable" "$file"
