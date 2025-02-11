---@type LazySpec
local spec = { 'mattn/vim-maketable' }

spec.cmd = {
	'MakeTable',
	'UnmakeTable',
}

local map = require('kjuq.utils.lazy').generate_map('', 'MakeTable: ')
spec.keys = {
	map('<Space>ct', 'n', [[m'<Cmd>lua vim.o.operatorfunc='v:lua.Kjuq_maketable'<CR>g@]], 'Make'),
	map('<Space>ct', 'x', ':MakeTable<CR>', 'Make'),
	map('<Space>cT', 'n', '<Cmd>UnmakeTable<CR>', 'Unmake'),
}

spec.config = function()
	function _G.kjuq_maketable()
		vim.cmd([[ '[,']MakeTable! ]])
	end
end

return spec
