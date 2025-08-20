local map = require('kjuq.utils.lazy').generate_map('', 'TreeSJ: ')

---@module 'lazy'
---@type LazySpec
local spec = { 'https://github.com/Wansmer/treesj' }

spec.keys = {
	map('<Space>ck', 'n', function()
		require('treesj').split()
	end, 'Split'),
}

spec.config = function()
	require('treesj').setup({
		use_default_keymaps = false,
	})
end

spec.dependencies = { 'nvim-treesitter/nvim-treesitter' }

return spec
