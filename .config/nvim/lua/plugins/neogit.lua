---@type LazySpec
local spec = { 'https://github.com/NeogitOrg/neogit' }

spec.cmd = { 'Neogit' }

local map = require('kjuq.utils.lazy').generate_map('', 'Neogit: ')
spec.keys = {
	map('<Space>gn', 'n', '<Cmd>Neogit kind=replace<CR>', 'open'),
}

spec.opts = {}

spec.specs = {
	'nvim-lua/plenary.nvim',
	'sindrets/diffview.nvim',
	'ibhagwan/fzf-lua',
}

return spec
