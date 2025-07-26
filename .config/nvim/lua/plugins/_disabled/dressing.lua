---@type LazySpec
local spec = { 'https://github.com/stevearc/dressing.nvim' }

spec.event = { 'VeryLazy' }

spec.opts = {
	input = {
		border = vim.o.winborder,
		mappings = {
			n = {
				['<Esc>'] = 'Close',
				['<CR>'] = 'Confirm',
			},
			i = {
				['<C-c>'] = false, -- `false` to disable
				['<Esc>'] = 'Close',
				['<CR>'] = 'Confirm',
				['<C-p>'] = 'HistoryPrev',
				['<C-n>'] = 'HistoryNext',
			},
		},
	},
	select = {
		backend = { 'builtin', 'nui', 'fzf_lua', 'telescope', 'fzf' },
		nui = {
			border = {
				style = require('kjuq.utils.common').floatwinborder,
			},
		},
		builtin = {
			border = require('kjuq.utils.common').floatwinborder,
			mappings = {
				['<Esc>'] = 'Close',
				['<C-c>'] = false, -- `false` to disable
				['<CR>'] = 'Confirm',
			},
		},
	},
}

spec.config = function(_, opts)
	vim.api.nvim_create_autocmd({ 'FileType' }, {
		pattern = 'DressingInput',
		group = vim.api.nvim_create_augroup('kjuq_dressing_input_local', {}),
		callback = function()
			vim.keymap.set('i', '<C-b>', '<Left>', { buffer = true })
			vim.keymap.set('i', '<C-f>', '<Right>', { buffer = true })
			vim.keymap.set('i', '<C-a>', '<Home>', { buffer = true })
			vim.keymap.set('i', '<C-e>', '<End>', { buffer = true })
			vim.keymap.set('i', '<C-d>', '<Del>', { buffer = true })
		end,
	})
	require('dressing').setup(opts)
end

return spec
