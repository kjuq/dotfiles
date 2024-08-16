local map = require('utils.lazy').generate_map('', 'Undotree: ')

---@type LazySpec
local spec = { 'jiaoshijie/undotree' }

spec.opts = {
	window = {
		winblend = 0,
	},
}

spec.keys = {
	map('<leader>au', 'n', function()
		require('undotree').toggle()
	end, 'Toggle'),
}

spec.specs = { 'nvim-lua/plenary.nvim' }

return spec
