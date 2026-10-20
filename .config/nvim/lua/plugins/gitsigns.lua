vim.pack.add({ 'https://github.com/lewis6991/gitsigns.nvim' })

-- Navigation
vim.keymap.set('n', ']g', function()
	if vim.wo.diff then
		return ']g'
	end
	vim.schedule(function()
		require('gitsigns').nav_hunk('next')
	end)
	return '<Ignore>'
end, { expr = true, desc = 'Gitsigns: Go to next hunk' })

vim.keymap.set('n', '[g', function()
	if vim.wo.diff then
		return '[g'
	end
	vim.schedule(function()
		require('gitsigns').nav_hunk('prev')
	end)
	return '<Ignore>'
end, { expr = true, desc = 'Gitsigns: Go to next hunk' })

-- Actions
vim.keymap.set('n', '<Space>gh', function()
	require('gitsigns').stage_hunk()
end, { desc = 'GitSigns: Stage hunk' })
vim.keymap.set('n', '<Space>gr', function()
	require('gitsigns').reset_hunk()
end, { desc = 'GitSigns: Reset hunk' })
vim.keymap.set('n', '<Space>gs', function()
	require('gitsigns').stage_buffer()
end, { desc = 'GitSigns: Stage buffer' })
vim.keymap.set('n', '<Space>gR', function()
	require('gitsigns').reset_buffer()
end, { desc = 'GitSigns: Reset buffer' })
vim.keymap.set('n', '<Space>gp', function()
	require('gitsigns').preview_hunk()
end, { desc = 'GitSigns: Preview hunk' })
vim.keymap.set('n', '<Space>gT', function()
	require('gitsigns').toggle_current_line_blame()
end, { desc = 'GitSigns: Toggle current line blame' })
vim.keymap.set('n', '<Space>gd', function()
	require('gitsigns').diffthis()
end, { desc = 'GitSigns: Diff this' })
vim.keymap.set('n', '<Space>gt', function()
	require('gitsigns').preview_hunk_inline()
end, { desc = 'GitSigns: Toggle deleted' })
vim.keymap.set('x', '<Space>gh', function()
	require('gitsigns').stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
end, { desc = 'GitSigns: Stage hunk' })
vim.keymap.set('x', '<Space>gr', function()
	require('gitsigns').reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
end, { desc = 'GitSigns: Reset hunk' })
vim.keymap.set('n', '<Space>gb', function()
	require('gitsigns').blame_line({ full = true })
end, { desc = 'GitSigns: Blame line' })
vim.keymap.set('n', '<Space>gD', function()
	require('gitsigns').diffthis('~')
end, { desc = 'GitSigns: Diff this "~" <- ?' })
vim.keymap.set({ 'o', 'x' }, '<Space>gS', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'GitSigns: Select hunk' })

require('gitsigns').setup({
	signcolumn = false,
	numhl = true,
})
