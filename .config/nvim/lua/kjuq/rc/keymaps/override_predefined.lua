vim.keymap.set({ 'n', 'x' }, '<Space>', '<Nop>')

-- Emacs-like cursor movement in command mode
vim.keymap.set('c', '<C-b>', '<Left>') -- Jumps to the beginning of a line by default
vim.keymap.set('c', '<C-f>', '<Right>') -- Opens a command-line window (q:) by default
vim.keymap.set('c', '<C-a>', '<Home>') -- Inserts all matched candidates by default, so <C-i> is enough
vim.keymap.set('c', '<C-d>', '<Del>') -- Lists completions by default, so <C-i> is enough
-- map("c", "<C-k>", "<c-\>e getcmdpos() == 1 ? '' : getcmdline()[:getcmdpos()-2]<CR>") -- Digraph is important
vim.keymap.set('c', '<C-x>', function()
	vim.fn.setreg('', vim.fn.getcmdline())
end)

-- recall history beginning with typed characters
vim.keymap.set('c', '<C-p>', '<Up>')
vim.keymap.set('c', '<C-n>', '<Down>')

vim.keymap.set('i', '<C-k>', '<Nop>')
vim.keymap.set('i', '<C-g><C-k>', '<C-k>')
vim.keymap.set('i', '<C-v>', '<Nop>')
vim.keymap.set('i', '<C-g><C-v>', '<C-v>')

vim.keymap.set('n', 'x', '"_x')
vim.keymap.set('n', 'X', '"_X')

-- Move caret on display lines
-- Comfortable line specify movement by v:count
vim.keymap.set({ 'n', 'x' }, 'k', function()
	return vim.v.count == 0 and 'gk' or 'k'
end, { expr = true, silent = true })
vim.keymap.set({ 'n', 'x' }, 'j', function()
	return vim.v.count == 0 and 'gj' or 'j'
end, { expr = true, silent = true })

vim.keymap.set('n', '<Esc>', function()
	vim.cmd.nohlsearch()
	vim.cmd.fclose({ bang = true })
	vim.cmd.execute([['normal \<Esc>']])
end, { silent = true })

vim.keymap.set({ 'i' }, '<C-l>', function()
	if vim.api.nvim_get_mode().mode ~= 'ix' then --  not in completion with <C-x>
		vim.cmd.fclose({ bang = true })
	end
end, { silent = true })

-- Buffer movement instead of tab's
vim.keymap.set('n', 'gt', vim.cmd.bnext, { silent = true, desc = 'Go to the next buffer' })
vim.keymap.set('n', 'gT', vim.cmd.bprevious, { silent = true, desc = 'Go to the previous buffer' })
vim.keymap.set('n', '<C-Tab>', 'gt', { remap = true, silent = true, desc = 'Alias for `gt`' })
vim.keymap.set('n', '<C-S-Tab>', 'gT', { remap = true, silent = true, desc = 'Alias for `gT`' })
