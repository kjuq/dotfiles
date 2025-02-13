vim.keymap.set('n', '<Space>cr', ':<C-u>%s///g<Left><Left>', { desc = 'Start substitution' })
vim.keymap.set('x', '<Space>cr', ":<C-u>'<,'>s///g<Left><Left>", { desc = 'Start substitution' })

vim.keymap.set('n', '<Space>cv', '`[v`]', { desc = 'Select last pasted range' })

-- TODO: dot repeat in Visual mode is broken
_G.kjuq_sort = function()
	vim.cmd([[ '[,']sort]])
end
vim.keymap.set('n', '<Space>cs', [[m'<Cmd>lua vim.o.operatorfunc='v:lua._G.kjuq_sort'<CR>g@]], { desc = 'Sort' })
vim.keymap.set('x', '<Space>cs', ':sort<CR>', { desc = 'Sort' })

_G.kjuq_sort_n = function()
	vim.cmd([[ '[,']sort n ]]) -- 'n' for numerical sort
end
vim.keymap.set('n', '<Space>cS', [[m'<Cmd>lua vim.o.operatorfunc='v:lua._G.kjuq_sort_n'<CR>g@]], { desc = 'Sort n' })
vim.keymap.set('x', '<Space>cS', [['<,'>:sort n<CR>]], { desc = 'Numerical sort' })

function _G.kjuq_source()
	vim.cmd([[ '[,']source ]])
end
vim.keymap.set('n', '<Space>cx', [[m'<Cmd>lua vim.o.operatorfunc='v:lua._G.kjuq_source'<CR>g@]], { desc = 'Source' })
vim.keymap.set('n', '<Space>cxx', '<Cmd>.source<CR>', { desc = 'Source' })
vim.keymap.set('x', '<Space>cx', ':source<CR>', { desc = 'Source' })

local rmb = require('rm-multibytes')
rmb.setup()
vim.keymap.set('n', '<Space>cj', function()
	return rmb.map()
end, { expr = true, desc = 'Remove multibytes' })
vim.keymap.set('x', '<Space>cj', ':KjuqRmMB<CR>', { desc = 'Remove multibytes' }) -- Broken
