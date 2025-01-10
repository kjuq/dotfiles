---@type LazySpec
local spec = { 'NeogitOrg/neogit' }

spec.cmd = { 'Neogit' }

local map = require('kjuq.utils.lazy').generate_map('', 'Neogit: ')
spec.keys = {
	map('<Space>gn', 'n', '<Cmd>Neogit kind=replace<CR>', 'open'),
}

spec.opts = {}

spec.dependencies = {
	'sindrets/diffview.nvim',
	'nvim-telescope/telescope.nvim',
}

spec.specs = {
	'nvim-lua/plenary.nvim',
}

return spec
