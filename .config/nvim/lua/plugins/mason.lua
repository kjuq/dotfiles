local cmap = require('utils.lazy').generate_map('<Space>', 'Mason: ')

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
		border = require('utils.common').floatwinborder,
	},
}

return spec
