---@module 'lazy'
---@type LazySpec
local spec = { 'https://github.com/pwntester/octo.nvim' }

spec.cmd = { 'Octo' }

spec.opts = {
	picker_config = {
		mappings = { -- mappings for the pickers
			open_in_browser = { lhs = '<C-x>', desc = 'open issue in browser' },
			copy_url = { lhs = '<M-c>', desc = 'copy url to system clipboard' },
			checkout_pr = { lhs = '<M-o>', desc = 'checkout pull request' },
			merge_pr = { lhs = '<M-m>', desc = 'merge pull request' },
		},
	},
}

spec.specs = {
	'nvim-lua/plenary.nvim',
	'nvim-tree/nvim-web-devicons',
	'ibhagwan/fzf-lua',
}

return spec
