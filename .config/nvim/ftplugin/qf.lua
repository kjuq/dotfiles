vim.keymap.set('n', '<C-m>', '<CR>:cclose<CR>', { buffer = true, silent = true, desc = 'Open a file' })
vim.keymap.set('n', 'o', '<CR>:cclose<CR>', { buffer = true, silent = true, desc = 'Open a file' })

-- <Cmd> and `|` are unusable (?) to avoid unnecessary message after `cclose`
-- Causes error when re-opening all files. How to reproduce:
-- 1. Press `O` at QFlist
-- 2. Delete a buffer of loaded files with `<Space>x` or `:bdelete`
-- 3. Re-open QF buffer with `:copen` or `<Space>sq`
-- 4. Press `O` again
-- 5. `E92: Buffer 13 not found` for example (!!)
vim.keymap.set(
	'n',
	'O',
	':<C-u>cfdo edit<CR>:<C-u>cclose<CR>',
	{ buffer = true, silent = true, desc = 'Open all files' }
)
