-- https://github.com/yutkat/wb-only-current-line.nvim

local M = {}

local motion = function(key, back_key)
	if vim.v.count1 > 1 then
		vim.cmd("normal! " .. vim.v.count1 .. key)
		return
	end

	local initial_line = vim.fn.line(".")
	vim.cmd("normal! " .. vim.v.count1 .. key)
	local new_line = vim.fn.line(".")

	if initial_line ~= new_line then
		vim.cmd("normal! " .. vim.v.count1 .. back_key)
	end
end

M.w = function()
	motion("w", "k$")
end
M.W = function()
	motion("W", "k$")
end
M.e = function()
	motion("e", "k$")
end
M.E = function()
	motion("E", "k$")
end
M.b = function()
	motion("b", "j^")
end
M.B = function()
	motion("B", "j^")
end
M.ge = function()
	motion("ge", "j^")
end
M.gE = function()
	motion("gE", "j^")
end

return M
