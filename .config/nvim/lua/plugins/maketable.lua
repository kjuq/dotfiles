---@module 'lazy'
---@type LazySpec
local spec = { 'https://github.com/mattn/vim-maketable' }

spec.cmd = {
	'MakeTable',
	'UnmakeTable',
}

local map = require('kjuq.lazy').generate_map('', 'MakeTable: ')
spec.keys = {
	map('<Space>ct', 'n', [[m'<Cmd>lua vim.o.operatorfunc='v:lua._G.kjuq_maketable'<CR>g@]], 'Make'),
	map('<Space>ct', 'x', ':MakeTable<CR>', 'Make'),
	map('<Space>cT', 'n', '<Cmd>UnmakeTable<CR>', 'Unmake'),
}

spec.config = function()
	function _G.kjuq_maketable()
		vim.cmd([[ '[,']MakeTable ]])
	end
end

return spec
