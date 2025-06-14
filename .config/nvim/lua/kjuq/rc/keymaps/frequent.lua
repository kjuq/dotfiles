-- Frequently used keymaps
vim.keymap.set('n', '<Space>w', '<Cmd>silent write<CR>', { desc = 'Write' })
vim.keymap.set('n', '<Space>W', '<Cmd>noautocmd silent write<CR>', { desc = 'Write noautocmd' })
vim.keymap.set('n', '<Space>d', vim.cmd.quit, { desc = 'Quit' })
vim.keymap.set('n', '<Space>D', vim.cmd.quitall, { desc = 'Quit all' })
vim.keymap.set('n', '<Space>Q', vim.cmd.restart, { desc = 'Restart' })
vim.keymap.set('n', '<Space>x', function()
	require('kjuq.utils.common').buffer_delete()
end, { desc = 'Delete buffer' })
vim.keymap.set('n', '<Space>X', function()
	require('kjuq.utils.common').buffer_delete('force')
end, { desc = 'Delete! buffer' })
vim.keymap.set('n', '<Space><C-x>', function()
	require('kjuq.utils.common').buffer_delete('others')
end, { desc = 'Clear buffers' })

vim.keymap.set('n', '<Space>y', '<C-w><C-w>', { desc = '<C-w>w' })

vim.keymap.set('n', '<Space>-', function()
	vim.cmd('Explore')
end, { desc = 'Open Netrw' })

vim.keymap.set('t', '<C-Tab>', '<Cmd>bnext<CR>', { desc = ':bnext' })
vim.keymap.set('t', '<S-Tab>', [[<C-\><C-n>]], { desc = 'Exit insert mode' })
