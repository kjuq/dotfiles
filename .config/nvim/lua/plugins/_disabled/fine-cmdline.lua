---@type LazySpec
local spec = { 'https://github.com/VonHeikemen/fine-cmdline.nvim' }

local map = require('kjuq.utils.lazy').generate_map('', 'Fine-cmdline: ')
spec.keys = {
	map(':', 'n', '<Cmd>FineCmdline<CR>', 'Float'),
	map(':', 'x', [[:<C-u>FineCmdline '<,'><CR>]], 'Float'),
	map('<Space>a:', { 'n', 'x' }, ':', 'Builtin'),
}

spec.opts = {
	cmdline = {
		enable_keymaps = true,
		smart_history = false,
		prompts = ' > ',
	},
	popup = {
		position = {
			row = '100%',
			col = '50%',
		},
		size = {
			width = '50%',
		},
		zindex = 999,
		border = {
			style = vim.o.winborder,
			text = {
				top = ' Cmdline ',
				top_align = 'center',
			},
		},
	},
	hooks = {
		after_mount = function(input)
			vim.keymap.set('i', '<C-p>', require('fine-cmdline').fn.up_search_history, { buffer = input.bufnr })
			vim.keymap.set('i', '<C-n>', require('fine-cmdline').fn.down_search_history, { buffer = input.bufnr })
		end,
	},
}

spec.specs = {
	'https://github.com/MunifTanjim/nui.nvim',
}

return spec
