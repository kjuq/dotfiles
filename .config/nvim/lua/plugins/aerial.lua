local map = require('kjuq.utils.lazy').generate_map('', 'Aerial: ')

---@type LazySpec
local spec = { 'stevearc/aerial.nvim' }

spec.keys = {
	map('gO', 'n', '<CMD>AerialToggle<CR>', 'Toggle'),
}

spec.opts = {
	backends = { 'lsp', 'treesitter', 'markdown', 'man' },
	keymaps = {
		['<Esc>'] = 'actions.close',
	},
	show_guides = true,
	layout = {
		default_direction = 'prefer_left',
	},
}

spec.dependencies = {
	'nvim-treesitter/nvim-treesitter',
}

spec.specs = {
	'nvim-tree/nvim-web-devicons',
}

return spec
