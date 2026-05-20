---@module 'lazy'
---@type LazySpec
local spec = { 'https://github.com/stevearc/aerial.nvim' }

spec.init = function()
	vim.api.nvim_create_autocmd({ 'FileType' }, {
		pattern = 'markdown',
		group = vim.api.nvim_create_augroup('kjuq_aerial_override_builtin_gO', {}),
		callback = function()
			vim.keymap.set('n', 'gO', require('aerial').open, { desc = 'Aerial: Toggle', buffer = true })
		end,
	})
end

spec.opts = {
	backends = { 'lsp', 'treesitter', 'markdown', 'man' },
	show_guides = true,
	layout = {
		default_direction = 'prefer_left',
	},
}

spec.specs = {
	'nvim-treesitter/nvim-treesitter',
}

return spec
