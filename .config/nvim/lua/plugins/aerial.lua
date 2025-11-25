local map = require('kjuq.lazy').generate_map('', 'Aerial: ')

---@module 'lazy'
---@type LazySpec
local spec = { 'https://github.com/stevearc/aerial.nvim' }

spec.keys = {
	map('gO', 'n', '<CMD>AerialToggle<CR>', 'Toggle'),
}

spec.init = function()
	vim.api.nvim_create_autocmd({ 'FileType' }, {
		pattern = 'markdown',
		group = vim.api.nvim_create_augroup('kjuq_disable_builtin_gO', {}),
		callback = function()
			vim.keymap.del('n', 'gO', { buffer = true })
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
