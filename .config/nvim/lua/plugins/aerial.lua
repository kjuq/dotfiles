vim.pack.add({ 'https://github.com/stevearc/aerial.nvim' })

vim.api.nvim_create_autocmd({ 'FileType' }, {
	pattern = 'markdown',
	group = vim.api.nvim_create_augroup('kjuq_aerial_override_builtin_gO', {}),
	callback = function()
		vim.keymap.set('n', 'gO', require('aerial').open, { desc = 'Aerial: Toggle', buffer = true })
	end,
})

require('aerial').setup({
	backends = { 'lsp', 'treesitter', 'markdown', 'man' },
	show_guides = true,
	layout = {
		default_direction = 'prefer_left',
	},
})

-- depends on nvim-treesitter
