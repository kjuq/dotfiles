local map = require('utils.lazy').generate_map('', 'Treesitter-unit: ')

---@type LazySpec
local spec = { 'David-Kunz/treesitter-unit' }

spec.keys = {
	map('au', 'o', function()
		require('treesitter-unit').select(true)
	end, 'Outer'),
	map('iu', 'o', function()
		require('treesitter-unit').select()
	end, 'Inner'),
	map('au', 'x', ":<C-u>lua require'treesitter-unit'.select(true)<CR>", 'Outer', { silent = true }),
	map('iu', 'x', ":<C-u>lua require'treesitter-unit'.select()<CR>", 'Inner', { silent = true }),
}

spec.dependencies = {
	'nvim-treesitter/nvim-treesitter',
}

return spec

-- `viu` will only select the node where your cursor is at the moment.
-- `vau` will select the next node after your cursor.
-- `vau` will also select the surroundings.
-- https://github.com/David-Kunz/treesitter-unit/issues/4
