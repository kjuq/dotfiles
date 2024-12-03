local cmap = require('utils.lazy').generate_map('<Space>', 'Mason: ')

---@type LazySpec
local spec = { 'williamboman/mason.nvim' }

spec.keys = { cmap('al', 'n', '<CMD>Mason<CR>', 'Open') }

spec.opts = {
	ui = {
		border = require('utils.common').floatwinborder,
	},
}

return spec
