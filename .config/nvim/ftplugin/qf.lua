vim.keymap.set('n', '<C-m>', '<CR>:cclose<CR>', { buffer = true, silent = true, desc = 'Open a file' })
vim.keymap.set('n', 'o', '<CR>:cclose<CR>', { buffer = true, silent = true, desc = 'Open a file' })

-- <Cmd> and `|` are unusable (?) to avoid unnecessary message after `cclose`
vim.keymap.set(
	'n',
	'O',
	':<C-u>cfdo edit<CR>:<C-u>cclose<CR>',
	{ buffer = true, silent = true, desc = 'Open all files' }
)
