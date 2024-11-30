---@type LazySpec
local spec = { 'folke/trouble.nvim' }

spec.cmd = {
	'Trouble',
}

local map = require('utils.lazy').generate_map('', 'Trouble: ')
spec.keys = {
	map('grl', 'n', '<CMD>Trouble diagnostics<CR>', 'Diagnostics'),
	map('<leader>aT', 'n', '<CMD>Trouble<CR>', 'Menu'),
}

spec.opts = {
	auto_preview = false,
	focus = true,
}

spec.specs = {
	'nvim-tree/nvim-web-devicons',
}

return spec
