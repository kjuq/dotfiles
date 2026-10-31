vim.pack.add({ 'https://github.com/Wansmer/treesj' })

vim.keymap.set('n', '<Space>ck', function()
	require('treesj').split()
end, { desc = 'TreeSJ: Split' })

require('treesj').setup({
	use_default_keymaps = false,
})

-- depends on nvim-treesitter
