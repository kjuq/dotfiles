vim.keymap.set({ 'n', 'x' }, '<Space>', '<Nop>')

vim.keymap.set({ 'n', 'i', 'x', 'c' }, '<Up>', '<C-p>', { remap = true })
vim.keymap.set({ 'n', 'i', 'x', 'c' }, '<Down>', '<C-n>', { remap = true })
vim.keymap.set({ 'n', 'i', 'x' }, '<Left>', '<C-b>', { remap = true })
vim.keymap.set({ 'n', 'i', 'x' }, '<Right>', '<C-f>', { remap = true })
vim.keymap.set({ 'n', 'i', 'x' }, '<Home>', '<C-a>', { remap = true })
vim.keymap.set({ 'n', 'i', 'x' }, '<End>', '<C-e>', { remap = true })
vim.keymap.set({ 'n', 'i', 'x' }, '<Del>', '<C-d>', { remap = true })
vim.keymap.set({ 'n', 'x' }, '<C-w><BS>', '<C-w><C-h>', { remap = true })
-- vim.keymap.set({ 'n', 'i', 'x' }, '<BS>', '<C-h>', { remap = true })
-- vim.keymap.set({ 'n', 'i', 'x' }, '<CR>', '<C-m>', { remap = true })
-- vim.keymap.set({ 'n', 'i', 'x' }, '<Tab>', '<C-i>', { remap = true })

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
vim.keymap.set('c', '<C-p>', function()
	return vim.fn.pumvisible() == 0 and '<Up>' or '<C-p>'
end, { expr = true })
vim.keymap.set('c', '<C-n>', function()
	return vim.fn.pumvisible() == 0 and '<Down>' or '<C-n>'
end, { expr = true })

vim.keymap.set('i', '<C-k>', '<Nop>')
vim.keymap.set('i', '<C-g><C-k>', '<C-k>')
vim.keymap.set('i', '<C-v>', '<Nop>')
vim.keymap.set('i', '<C-g><C-v>', '<C-v>')

vim.keymap.set('n', 'x', '"_x')
vim.keymap.set('n', 'X', '"_X')

vim.keymap.set('i', '<C-y>', function()
	local mode = vim.api.nvim_get_mode().mode
	if mode ~= 'ic' then
		return '<C-y>'
	end
	local selected = vim.fn.complete_info({ 'selected' }).selected ~= -1
	if not selected then
		return '<C-n><C-y>'
	else
		return '<C-y>'
	end
end, { expr = true })

-- vim.keymap.set('i', '<C-n>', function()
-- 	local mode = vim.api.nvim_get_mode().mode
-- 	if mode ~= 'ic' then
-- 		return '<C-n><C-n>'
-- 	else
-- 		return '<C-n>'
-- 	end
-- 	-- if not selected then
-- 	-- 	return '<C-n><C-n>'
-- 	-- else
-- 	-- 	return '<C-n>'
-- 	-- end
-- end, { expr = true })

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
	return '<Cmd>fclose<CR><Esc>'
end, { expr = true, silent = true })

vim.keymap.set({ 'i' }, '<C-l>', function()
	if vim.api.nvim_get_mode().mode ~= 'ix' then --  not in completion with <C-x>
		vim.cmd.fclose({ bang = true })
	end
end, { silent = true })

vim.keymap.set('n', '<M-q>', function()
	local reg = vim.fn.reg_recorded()
	return reg == '' and '' or ('@' .. reg)
end, { expr = true })

vim.keymap.set('n', '<Space>cr', ':<C-u>%s///g<Left><Left>', { desc = 'Start substitution' })
vim.keymap.set('x', '<Space>cr', ":<C-u>'<,'>s///g<Left><Left>", { desc = 'Start substitution' })

function _G.kjuq_sortmotion()
	vim.cmd([[ '[,']sort n ]])
end

vim.keymap.set('n', '<Space>cs', [[m'<Cmd>lua vim.o.operatorfunc='v:lua._G.kjuq_sortmotion'<CR>g@]], { desc = 'Sort' })
vim.keymap.set('x', '<Space>cs', ':sort n<CR>', { desc = 'Sort' }) -- NOTE: dot-register is not updated with visual mode

vim.keymap.set('n', '<Space>cv', '`[v`]', { desc = 'Select last pasted range' })

vim.keymap.set('n', '<Space>sq', '<CMD>copen<CR>', { desc = 'Open QuickFix window' })
vim.keymap.set('n', '<Space>sm', '<CMD>messages<CR>', { desc = 'History of messages' })

vim.keymap.set('n', '<space>am', function()
	vim.ui.input({ prompt = '$ ', completion = 'shellcmdline' }, function(c)
		if c and c ~= '' then
			vim.cmd('noswapfile enew')
			vim.bo.buftype = 'nofile'
			-- vim.bo.bufhidden = 'wipe'
			vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.fn.systemlist(c))
		end
	end)
end)

-- Frequently used keymaps
vim.keymap.set('n', '<Space>w', vim.cmd.write, { desc = 'Write' })
vim.keymap.set('n', '<Space>d', vim.cmd.quit, { desc = 'Quit' })

vim.keymap.set('n', '<Space>-', '<Plug>(nvim-dir-up)', { desc = ':Explore' })

vim.keymap.set('t', '<S-Tab>', [[<C-\><C-n>]], { desc = 'Exit insert mode' })

-- LSP:
-- neovim/runtime/lua/vim/lsp.lua > lsp._set_defaults
vim.keymap.set('n', 'gr', '<Nop>')

local vlb = vim.lsp.buf

vim.keymap.set('n', 'grl', '<Cmd>lsp restart<CR><Cmd>echomsg "Done :lsp restart"<CR>', { desc = 'LSP: Restart LS' })
vim.keymap.set('n', 'grd', vlb.declaration, { desc = 'LSP: Go to Declaration' })
vim.keymap.set('n', 'grh', vlb.typehierarchy, { desc = 'LSP: Type hierarchy' })
vim.keymap.set('n', 'grc', vlb.incoming_calls, { desc = 'LSP: Incoming calls' })
vim.keymap.set('n', 'grg', vlb.outgoing_calls, { desc = 'LSP: Outgoing calls' })
vim.keymap.set('n', '<M-e>', vim.diagnostic.open_float, { desc = 'LSP: Show diagnostics' })
vim.keymap.set('n', '<C-s>', vim.lsp.buf.signature_help, { desc = 'LSP: Signature Help' })
