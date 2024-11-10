---@type LazySpec
local spec = { 'j-hui/fidget.nvim' }
spec.event = { 'LspAttach', 'VeryLazy' }

local map = require('utils.lazy').generate_map('', 'Fidget: ')
spec.keys = {
	map('<leader>aa', 'n', '<Cmd>Fidget history<CR>', 'History'),
}

spec.opts = {
	notification = {
		override_vim_notify = true,
		window = {
			winblend = 0,
			border = require('utils.common').floatwinborder,
		},
	},
}

return spec
