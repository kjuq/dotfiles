-- TODO: highlight when reaching at top and bottom
-- FIXME: <C-d> and <C-f> break when `wrap` is enabled

M = {}

local linesum = function()
	return vim.fn.line('$')
end

local bottom = function()
	return vim.fn.line('w$') -- displayed bottom line
end

local top = function()
	return vim.fn.line('w0') -- displayed top line
end

local win_height = function()
	return vim.fn.winheight(0)
end

local visual_height = function()
	return bottom() - top() + 1
end

local is_bottom = function()
	return bottom() == linesum()
end

local is_top = function()
	return top() == 1
end

local is_wrapped = function(linenum)
	return vim.fn.virtcol({ linenum, '$' }) > vim.fn.winwidth(0)
end

local wrapped_lines_num = function()
	local cnt = 0
	for linenum = top(), bottom() do
		if is_wrapped(linenum) then
			cnt = cnt + 1
		end
	end
	return cnt
end

local is_exceeded = function()
	return visual_height() < win_height() - wrapped_lines_num()
end

local cursor_line = function()
	return vim.fn.getcurpos(0)[2]
end

local relative_cursorline = function()
	return cursor_line() - top() + 1
end

local scroll_down = function(key)
	if is_bottom() then
		return
	end
	local initial_rel_line = relative_cursorline()
	vim.cmd.execute([["normal! \]] .. key .. '"')

	if is_exceeded() then -- only for <C-f>
		vim.cmd.normal({ args = { 'Gzb' }, bang = true })
	end

	local new_line
	if initial_rel_line <= vim.o.scrolloff then
		new_line = top() + vim.o.scrolloff
	else
		new_line = top() + initial_rel_line - 1
	end

	-- force `startofline` like behavior (It is too hard to implement `nostartofline`)
	vim.fn.cursor(new_line, 0)
end

local scroll_up = function(key)
	if is_top() then
		return
	end
	local initial_rel_line = relative_cursorline()
	vim.cmd.execute([["normal! \]] .. key .. '"')

	local new_line
	if initial_rel_line >= win_height() - vim.o.scrolloff then
		new_line = bottom() - vim.o.scrolloff
	else
		new_line = top() + initial_rel_line - 1
	end

	-- `startofline` same as scroll_down
	vim.fn.cursor(new_line, 0)
end

M.cd = function()
	scroll_down('<C-d>')
end
M.cf = function()
	scroll_down('<C-f>')
end
M.cu = function()
	scroll_up('<C-u>')
end
M.cb = function()
	scroll_up('<C-b>')
end

return M
