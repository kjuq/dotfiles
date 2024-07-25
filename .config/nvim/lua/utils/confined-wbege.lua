-- https://github.com/yutkat/wb-only-current-line.nvim

local M = {}

M.motion = function(motion)
	-- TODO: implement operator pending mode
	-- TODO: not moving cursor when the cursor on the posision beyond a first non-blank char (ie. indent)

	local initial_line = vim.fn.line(".")
	local initial_bottom = vim.fn.line("w$") -- displayed bottom line
	local initial_top = vim.fn.line("w0")
	local visual_lines = initial_bottom - initial_top + 1

	-- HACK: alleviate unexpected scroll
	local max_count = visual_lines - vim.o.scrolloff * 2
	if vim.v.count1 > max_count then
		vim.notify(
			"Confined-wbege: Too many counts (" .. vim.v.count1 .. " > " .. max_count .. ")",
			vim.log.levels.WARN
		)
		return
	end

	motion()

	local new_line = vim.fn.line(".")
	local new_bottom = vim.fn.line("w$")

	local line_diff = new_line - initial_line
	if line_diff == 0 then
		return
	end

	local newline_is_below_init_line = line_diff > 0
	local newline_is_above_init_line = line_diff < 0

	local back_key
	if newline_is_below_init_line then
		back_key = "k$"
	elseif newline_is_above_init_line then
		back_key = "j^"
	end

	local back_count = math.abs(line_diff)
	vim.cmd("normal! " .. back_count .. back_key)

	local scroll_diff = new_bottom - initial_bottom
	if scroll_diff == 0 then
		return
	end

	local scrolled_down = scroll_diff > 0
	local scrolled_up = scroll_diff < 0

	local scroll_back
	if scrolled_down then
		scroll_back = "\\<C-y>"
	elseif scrolled_up then
		scroll_back = "\\<C-e>"
	end

	local scroll_count = math.abs(scroll_diff)
	vim.cmd('execute "normal! ' .. scroll_count .. scroll_back .. '"')
end

local key_motion = function(key)
	M.motion(function()
		return vim.cmd("normal! " .. vim.v.count1 .. key)
	end)
end

M.w = function()
	key_motion("w")
end
M.W = function()
	key_motion("W")
end
M.e = function()
	key_motion("e")
end
M.E = function()
	key_motion("E")
end
M.b = function()
	key_motion("b")
end
M.B = function()
	key_motion("B")
end
M.ge = function()
	key_motion("ge")
end
M.gE = function()
	key_motion("gE")
end

return M
