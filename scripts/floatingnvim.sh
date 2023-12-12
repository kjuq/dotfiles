#!/usr/bin/env bash

tmp="/tmp/floatingnvim_tmp_nae18aA6ARaiOF"

wezterm --config initial_rows=10 --config initial_cols=70 start --class FloatingVim fish -c \
    "nvim -c 'startinsert' '$tmp' \
    && [ -e '$tmp' ] \
    && head -c -1 '$tmp' | pbcopy \
    && command rm '$tmp'"
