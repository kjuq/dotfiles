vim.keymap.set('n', '<Space>cr', ':<C-u>%s///g<Left><Left>', { desc = 'Start substitution' })
vim.keymap.set('x', '<Space>cr', ":<C-u>'<,'>s///g<Left><Left>", { desc = 'Start substitution' })

-- sort motion
_G.kjuq_sort = function()
	vim.cmd([[ '[,']sort n ]]) -- 'n' for numerical sort
end

vim.keymap.set('n', '<Space>cs', [[m'<Cmd>lua vim.o.operatorfunc='v:lua._G.kjuq_sort'<CR>g@]], { desc = 'Sort' })
vim.keymap.set('x', '<Space>cs', ':sort<CR>', { desc = 'Sort' })

vim.keymap.set('n', '<Space>cv', '`[v`]', { desc = 'Select last pasted range' })
