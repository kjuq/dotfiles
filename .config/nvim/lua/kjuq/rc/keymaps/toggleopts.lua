vim.keymap.set('n', '<Space>tw', function()
	vim.opt.wrap = not vim.o.wrap
	if vim.o.wrap then
		vim.notify('Wrap enabled')
	else
		vim.notify('Wrap disabled')
	end
end, { desc = 'Toggle wrap' })

vim.keymap.set('n', '<Space>tS', function()
	vim.opt.spell = not vim.o.spell
	if vim.o.spell then
		vim.notify('Spellcheck enabled')
	else
		vim.notify('Spellcheck disabled')
	end
end, { desc = 'Toggle spell check' })

vim.keymap.set('n', '<Space>th', function()
	vim.opt.cursorline = not vim.o.cursorline
end, { desc = 'Toggle cursorline' })

vim.keymap.set('n', '<Space>tH', function()
	vim.opt.cursorcolumn = not vim.o.cursorcolumn
end, { desc = 'Toggle cursorcolumn' })

vim.keymap.set('n', '<Space>tL', function()
	vim.opt.list = not vim.o.list
end, { desc = 'Toggle list' })

vim.keymap.set('n', '<Space>ts', function()
	vim.o.laststatus = vim.o.laststatus == 0 and 3 or 0
end, { desc = 'Toggle statusline' })

vim.keymap.set('n', '<Space>tn', function()
	vim.opt.number = not vim.o.number
end, { desc = 'Toggle number' })

vim.keymap.set('n', '<M-n>', function()
	vim.opt.number = not vim.o.number
end, { desc = 'Toggle number' })

vim.keymap.set('n', '<Space>tN', function()
	vim.opt.relativenumber = not vim.o.relativenumber
end, { desc = 'Toggle relnum' })

vim.keymap.set('n', '<Space>tc', function()
	if vim.o.clipboard == '' then
		vim.o.clipboard = 'unnamedplus'
	else
		vim.o.clipboard = ''
	end
	vim.notify('clipboard=' .. vim.o.clipboard)
end, { desc = 'Toggle clipboard' })

local vedit_default
vim.keymap.set('n', '<Space>tv', function()
	if not vedit_default then
		vedit_default = vim.o.virtualedit
	end
	if vim.o.virtualedit == vedit_default then
		vim.opt.virtualedit = 'all'
	else
		vim.opt.virtualedit = vedit_default
	end
	vim.notify('virtualedit=' .. vim.o.virtualedit)
end, { desc = 'Toggle virtualedit' })

vim.keymap.set('n', '<Space>tf', function()
	if vim.o.foldmethod == 'expr' then
		vim.opt.foldmethod = 'marker'
	else
		vim.opt.foldmethod = 'expr'
	end
	vim.notify('foldmethod=' .. vim.o.foldmethod)
end, { desc = 'Toggle foldmethod' })

-- variable keybinds on states
local vedit_replace = false
vim.keymap.set({ 'n' }, 'r', function()
	return vedit_replace and 'gr' or 'r'
end, { expr = true })
vim.keymap.set({ 'n' }, 'R', function()
	return vedit_replace and 'gR' or 'R'
end, { expr = true })
vim.keymap.set('n', '<Space>tr', function()
	vedit_replace = not vedit_replace
	vim.notify('Virtual edit replace: ' .. tostring(vedit_replace))
end, { desc = 'Toggle vedit replace' })

local vt_bak
vim.keymap.set('n', '<Space>td', function()
	vt_bak = vt_bak == nil and vim.diagnostic.config().virtual_text or vt_bak
	if vim.diagnostic.config().virtual_text then
		vim.diagnostic.config({ virtual_text = false })
	else
		vim.diagnostic.config({ virtual_text = vt_bak })
	end
end, { desc = 'LSP: Toggle virtual text of diagnotics' })
