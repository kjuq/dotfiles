---@type LazySpec
local spec = { 'mattn/vim-maketable' }

spec.cmd = {
	'MakeTable',
	'UnmakeTable',
}

local map = require('utils.lazy').generate_map('', 'MakeTable: ')
spec.keys = {
	map('<Space>ct', 'n', [[m'<Cmd>lua vim.o.operatorfunc='v:lua.kjuq_maketable'<CR>g@]], 'Make'),
	map('<Space>ct', 'x', ':MakeTable<CR>', 'Make'),
	map('<Space>cT', 'n', '<Cmd>UnmakeTable<CR>', 'Unmake'),
}

spec.config = function()
	_G.kjuq_maketable = function()
		vim.cmd([[ '[,']MakeTable! ]])
		vim.fn.setpos('.', vim.fn.getpos("''"))
	end
end

return spec
