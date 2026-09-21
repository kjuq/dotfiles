vim.pack.add({ 'https://github.com/chrisgrieser/nvim-various-textobjs' })

local map = require('kjuq.lazy').generate_map('', 'Various-textobjs: ')

vim.keymap.set({ 'o', 'x' }, 'ii', function()
	if vim.fn.indent('.') == 0 then
		require('various-textobjs').entireBuffer()
	else
		require('various-textobjs').indentation('inner', 'inner')
	end
end, { desc = 'Various-textobjs: Indentation (inner without blanks)' })

vim.keymap.set({ 'o', 'x' }, 'ai', function()
	if vim.fn.indent('.') == 0 then
		require('various-textobjs').entireBuffer()
	else
		require('various-textobjs').indentation('outer', 'outer')
	end
end, { desc = 'Various-textobjs: Indentation (outer without blanks)' })

vim.keymap.set({ 'o', 'x' }, 'ir', function()
	require('various-textobjs').subword('inner', 'inner')
end, { desc = 'Various-textobjs: Subword (inner)' })
vim.keymap.set({ 'o', 'x' }, 'ar', function()
	require('various-textobjs').subword('outer', 'outer')
end, { desc = 'Various-textobjs: Subword (outer)' })

vim.keymap.set({ 'o', 'x' }, 'iq', function()
	require('various-textobjs').anyQuote('inner', 'inner')
end, { desc = 'Various-textobjs: Any Quote (inner)' })
vim.keymap.set({ 'o', 'x' }, 'aq', function()
	require('various-textobjs').anyQuote('outer', 'outer')
end, { desc = 'Various-textobjs: Any Quote (outer)' })

require('various-textobjs').setup({
	lookForwarding = {
		big = 15,
		small = 5,
	},
	keymaps = {
		useDefaults = false,
	},
	notify = {
		whenObjectNotFound = false,
	},
	textobjs = {
		indent = {
			blanksAreDelimiter = true,
		},
	},
})
