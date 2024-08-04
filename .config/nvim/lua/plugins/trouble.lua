local map = require('utils.lazy').generate_map('<leader>t', 'Trouble: ')

---@type LazySpec
local spec = { 'folke/trouble.nvim' }

spec.cmd = {
	'Trouble',
}

spec.keys = {
	map('o', 'n', '<CMD>Trouble diagnostics<CR>', 'Toggle'),
	map('r', 'n', '<CMD>Trouble lsp<CR>', 'Toggle lsp'),
}

spec.opts = {}

spec.specs = {
	'nvim-tree/nvim-web-devicons',
}

return spec
