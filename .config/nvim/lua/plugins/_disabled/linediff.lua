local map = require('kjuq.utils.lazy').generate_map('<Space>a', 'Linediff: ')

---@type LazySpec
local spec = { 'https://github.com/AndrewRadev/linediff.vim' }
spec.cmd = { 'Linediff' }

spec.keys = {
	map('d', 'x', function()
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<esc>', true, false, true), 'x', false)
		vim.cmd("'<,'>Linediff")
	end, 'Set range'),
	map('d', 'n', function()
		vim.cmd('LinediffReset')
	end, 'Linediff Reset current selection'),
}

return spec
