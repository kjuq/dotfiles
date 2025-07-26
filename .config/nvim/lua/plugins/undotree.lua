local map = require('kjuq.utils.lazy').generate_map('', 'Undotree: ')

---@type LazySpec
local spec = { 'https://github.com/jiaoshijie/undotree' }

spec.opts = {
	window = {
		winblend = 0,
	},
}

spec.keys = {
	map('<Space>au', 'n', function()
		require('undotree').toggle()
	end, 'Open UI'),
}

spec.specs = { 'nvim-lua/plenary.nvim' }

return spec
