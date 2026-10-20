vim.pack.add({ 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects' })

vim.keymap.set({ 'x', 'o' }, 'aa', function()
	require('nvim-treesitter-textobjects.select').select_textobject('@parameter.outer', 'textobjects')
end, { desc = 'TS-Textobjs: @parameter.outer' })
vim.keymap.set({ 'x', 'o' }, 'ia', function()
	require('nvim-treesitter-textobjects.select').select_textobject('@parameter.inner', 'textobjects')
end, { desc = 'TS-Textobjs: @parameter.inner' })
vim.keymap.set({ 'x', 'o' }, 'af', function()
	require('nvim-treesitter-textobjects.select').select_textobject('@function.outer', 'textobjects')
end, { desc = 'TS-Textobjs: @function.outer' })
vim.keymap.set({ 'x', 'o' }, 'if', function()
	require('nvim-treesitter-textobjects.select').select_textobject('@function.inner', 'textobjects')
end, { desc = 'TS-Textobjs: @function.inner' })

vim.keymap.set({ 'x', 'o' }, 'ac', function()
	require('nvim-treesitter-textobjects.select').select_textobject('@codeblock.outer', 'textobjects')
end, { desc = 'TS-Textobjs: @function.outer' })
vim.keymap.set({ 'x', 'o' }, 'ic', function()
	require('nvim-treesitter-textobjects.select').select_textobject('@codeblock.inner', 'textobjects')
end, { desc = 'TS-Textobjs: @function.inner' })

vim.keymap.set({ 'x', 'o' }, 'aC', function()
	require('nvim-treesitter-textobjects.select').select_textobject('@class.outer', 'textobjects')
end, { desc = 'TS-Textobjs: @class.outer' })
vim.keymap.set({ 'x', 'o' }, 'iC', function()
	require('nvim-treesitter-textobjects.select').select_textobject('@class.inner', 'textobjects')
end, { desc = 'TS-Textobjs: @class.inner' })
vim.keymap.set({ 'x', 'o' }, 'aT', function()
	require('nvim-treesitter-textobjects.select').select_textobject('@conditional.outer', 'textobjects')
end, { desc = 'TS-Textobjs: @conditional.outer' })
vim.keymap.set({ 'x', 'o' }, 'iT', function()
	require('nvim-treesitter-textobjects.select').select_textobject('@conditional.inner', 'textobjects')
end, { desc = 'TS-Textobjs: @conditional.inner' })
vim.keymap.set('n', '<M-t>', function()
	require('nvim-treesitter-textobjects.swap').swap_next('@parameter.inner')
end, { desc = 'TS-Textobjs: Swap forward' })
vim.keymap.set('n', '<M-g>', function()
	require('nvim-treesitter-textobjects.swap').swap_previous('@parameter.inner')
end, { desc = 'TS-Textobjs: Swap backward' })

require('nvim-treesitter-textobjects').setup({
	select = {
		lookahead = true,
	},
	move = {
		set_jumps = true,
	},
})
