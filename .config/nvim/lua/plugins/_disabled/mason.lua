local cmap = require('kjuq.utils.lazy').generate_map('<Space>', 'Mason: ')

---@type LazySpec
local spec = { 'williamboman/mason.nvim' }

spec.cmd = {
	'Mason',
	'MasonInstall',
	'MasonUninstall',
	'MasonUninstallAll',
	'MasonLog',
}

spec.opts = {
	ui = {
		border = vim.o.winborder,
	},
}

return spec
