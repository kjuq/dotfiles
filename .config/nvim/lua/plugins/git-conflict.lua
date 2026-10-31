vim.pack.add({ 'https://github.com/akinsho/git-conflict.nvim' })

vim.keymap.set('n', '<Space>gcl', '<Cmd>GitConflictListQf<CR>', { desc = 'Git-conflict: List QuickFix' })
vim.keymap.set('n', '<Space>gci', '<Cmd>GitConflictChooseTheirs<CR>', { desc = 'Git-conflict: Choose theirs' })
vim.keymap.set('n', '<Space>gco', '<Cmd>GitConflictChooseOurs<CR>', { desc = 'Git-conflict: Choose ours' })
vim.keymap.set('n', '<Space>gca', '<Cmd>GitConflictChooseBoth<CR>', { desc = 'Git-conflict: Choose both (all)' })
vim.keymap.set('n', '<Space>gcn', '<Cmd>GitConflictChooseNone<CR>', { desc = 'Git-conflict: Choose none' })
vim.keymap.set('n', '<Space>gcb', '<Cmd>GitConflictChooseBase<CR>', { desc = 'Git-conflict: Choose base' })
vim.keymap.set('n', ']c', '<Cmd>GitConflictNextConflict<CR>', { desc = 'Git-conflict: Next conflict' })
vim.keymap.set('n', '[c', '<Cmd>GitConflictPrevConflict<CR>', { desc = 'Git-conflict: Previous conflict' })

require('git-conflict').setup({
	default_mappings = false,
	highlights = {
		incoming = 'DiffAdd',
		current = 'DiffDelete',
	},
})
