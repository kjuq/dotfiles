---@type LazySpec
local spec = { 'NeogitOrg/neogit' }

spec.cmd = { 'Neogit' }

local map = require('utils.lazy').generate_map('', 'Neogit: ')
spec.keys = {
	map('<leader>gn', 'n', '<Cmd>Neogit kind=replace<CR>', 'open'),
}

spec.opts = {}

spec.dependencies = {
	'nvim-lua/plenary.nvim',
	'sindrets/diffview.nvim',
	'nvim-telescope/telescope.nvim',
}

return spec
