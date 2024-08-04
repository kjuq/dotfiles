---@type LazySpec
local spec = { 'j-hui/fidget.nvim' }
spec.event = { 'LspAttach', 'VeryLazy' }

local map = require('utils.lazy').generate_map('', 'Fidget: ')
spec.keys = {
	map('<leader>aa', 'n', '<Cmd>Fidget history<CR>', 'History'),
}

spec.opts = {
	notification = {
		filter = vim.log.levels.TRACE,
		override_vim_notify = true,
		window = {
			normal_hl = 'user_fidget_window',
			winblend = 0,
		},
	},
}

spec.config = function(_, opts)
	vim.api.nvim_set_hl(0, 'user_fidget_window', { bg = '#000000' })
	require('fidget').setup(opts)
end

return spec
