---@module 'lazy'
---@type LazySpec
local spec = { 'https://github.com/j-hui/fidget.nvim' }
spec.event = { 'LspAttach' }

local map = require('kjuq.utils.lazy').generate_map('', 'Fidget: ')
spec.keys = {
	map('<Space>an', 'n', '<Cmd>Fidget history<CR>', 'History'),
	map('<Space>sn', 'n', function()
		if vim.fn.exists(':Capture') == 0 then
			return
		end
		return '<Cmd>Capture Fidget history<CR>'
	end, 'Open history as a buffer', { expr = true }),
}

spec.opts = {
	progress = {
		ignore_done_already = true, -- Ignore new tasks that are already complete
		ignore_empty_message = true,
		display = {
			done_ttl = 0.5,
		},
	},
	notification = {
		override_vim_notify = false,
		configs = {
			default = vim.tbl_extend('force', require('fidget.notification').default_config, {
				ttl = 1.5,
			}),
		},
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
