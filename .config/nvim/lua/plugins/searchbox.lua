---@module 'lazy'
---@type LazySpec
local spec = { 'https://github.com/VonHeikemen/searchbox.nvim' }

local map = require('kjuq.utils.lazy').generate_map('', 'Searchbox: ')
spec.keys = {
	map('/', 'n', '<Cmd>SearchBoxIncSearch<CR>', 'Search'),
	map('/', 'x', '<Cmd>SearchBoxIncSearch visual_mode=true<CR>', 'Search'),
	map('<Space>a/', { 'n', 'x' }, '/', 'Normal /'),
}

spec.opts = {
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
				top = ' Search ',
				top_align = 'center',
			},
		},
	},
	hooks = {
		after_mount = function(input)
			vim.keymap.set('i', '<C-b>', '<Left>', { buffer = input.bufnr })
			vim.keymap.set('i', '<C-f>', '<Right>', { buffer = input.bufnr })
			vim.keymap.set('i', '<C-a>', '<Home>', { buffer = input.bufnr })
			vim.keymap.set('i', '<C-e>', '<End>', { buffer = input.bufnr })
			vim.keymap.set('i', '<C-d>', '<Del>', { buffer = input.bufnr })
			vim.keymap.set('i', '<C-w>', '<C-w>', { buffer = input.bufnr }) -- not working :(
		end,
	},
}

spec.specs = {
	'https://github.com/MunifTanjim/nui.nvim',
}

return spec
