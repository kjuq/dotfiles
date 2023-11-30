function nvimcopy --description="Open nvim for copying text"
	set --local tmp "/tmp/clip_tmp_nae18aA6ARaiOF"
	nvim -c "startinsert" "$tmp"; and head -c -1 "$tmp" | pbcopy; and command rm "$tmp"
end
