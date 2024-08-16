local map = require('utils.lazy').generate_map('<leader>a', 'Linediff: ')

---@type LazySpec
local spec = { 'AndrewRadev/linediff.vim' }
spec.cmd = { 'Linediff' }

spec.keys = {
	map('f', 'x', function()
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<esc>', true, false, true), 'x', false)
		vim.cmd("'<,'>Linediff")
	end, 'Set range'),
	map('f', 'n', function()
		vim.cmd('LinediffReset')
	end, 'Linediff Reset current selection'),
}

return spec
