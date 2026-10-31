vim.pack.add({ 'https://github.com/linrongbin16/gitlinker.nvim' })

vim.keymap.set({ 'n', 'x' }, '<Space>gy', '<Cmd>GitLink<CR>', { desc = 'Gitlinker: Yank git link' })
vim.keymap.set({ 'n', 'x' }, '<Space>gY', '<Cmd>GitLink!<CR>', { desc = 'Gitlinker: Open git link' })
