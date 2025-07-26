---@type LazySpec
local spec = { 'https://github.com/j-hui/fidget.nvim' }
spec.event = { 'LspAttach' }

local map = require('kjuq.utils.lazy').generate_map('', 'Fidget: ')
spec.keys = {
	map('<Space>aa', 'n', '<Cmd>Fidget history<CR>', 'History'),
}

spec.opts = {
	notification = {
		override_vim_notify = true,
		view = {
			stack_upwards = false, -- Display notification items from bottom to top
		},
		window = {
			winblend = 0,
			align = 'top',
			border = vim.o.winborder,
		},
	},
}

return spec
