local map = require('utils.lazy').generate_map('', 'TreeSJ: ')

---@type LazySpec
local spec = { 'Wansmer/treesj' }

spec.keys = {
	map('gK', 'n', function()
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
