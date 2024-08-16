local M = {}

---@return jolyne.Positions
local get_cur_poses = function()
	local line = vim.fn.line('.')
	local bottom = vim.fn.line('w$') -- displayed bottom line
	local top = vim.fn.line('w0')
	local height = bottom - top + 1
	return {
		line = line,
		bottom = bottom,
		top = top,
		height = height,
	}
end

---@param pos jolyne.Positions
---@return boolean
local counts_exceeded = function(pos)
	-- FIX: revert scroll after back_scroll and remove this section
	-- HACK: alleviate unexpected scroll
	local max_count = math.max(pos.height, pos.height - (vim.o.scrolloff + 1) * 2)
	return vim.v.count1 > max_count
end

---@param newpos jolyne.Positions
---@param oldpos jolyne.Positions
local back_exceeded_words = function(newpos, oldpos)
	local line_diff = newpos.line - oldpos.line
	if line_diff == 0 then
		return
	end

	local newline_is_below_init_line = line_diff > 0
	local newline_is_above_init_line = line_diff < 0

	local back_key
	if newline_is_below_init_line then
		back_key = 'k$'
	elseif newline_is_above_init_line then
		back_key = 'j^'
	end

	local back_count = math.abs(line_diff)
	vim.cmd('normal! ' .. back_count .. back_key)
end

---@param newpos jolyne.Positions
---@param oldpos jolyne.Positions
local back_exceeded_scrolls = function(newpos, oldpos)
	local scroll_diff = newpos.bottom - oldpos.bottom
	if scroll_diff == 0 then
		return
	end

	local scrolled_down = scroll_diff > 0
	local scrolled_up = scroll_diff < 0

	local scroll_back
	if scrolled_down then
		scroll_back = '\\<C-y>'
	elseif scrolled_up then
		scroll_back = '\\<C-e>'
	end

	local scroll_count = math.abs(scroll_diff)
	vim.cmd('execute "normal! ' .. scroll_count .. scroll_back .. '"')
end

M.motion = function(motion)
	-- TODO: implement operator pending mode
	-- TODO: not moving cursor when the cursor on the posision beyond a first non-blank char (ie. indent)
	local initpos = get_cur_poses()
	if counts_exceeded(initpos) then
		vim.notify('Jolyne: Too many counts (' .. vim.v.count1 .. ')', vim.log.levels.WARN)
		return
	end
	motion()
	local newpos = get_cur_poses()
	back_exceeded_words(newpos, initpos)
	back_exceeded_scrolls(newpos, initpos)
end

local key_motion = function(key)
	M.motion(function()
		return vim.cmd('normal! ' .. vim.v.count1 .. key)
	end)
end

M.w = function()
	key_motion('w')
end
M.W = function()
	key_motion('W')
end
M.e = function()
	key_motion('e')
end
M.E = function()
	key_motion('E')
end
M.b = function()
	key_motion('b')
end
M.B = function()
	key_motion('B')
end
M.ge = function()
	key_motion('ge')
end
M.gE = function()
	key_motion('gE')
end

return M
