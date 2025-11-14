local doc = os.getenv('KJUQ_DOCS')
local confroot = os.getenv('XDG_CONFIG_HOME') .. '/nvim'

vim.api.nvim_create_user_command('EditDashboard', function()
	local path = vim.fs.joinpath(doc, '__index.md')
	vim.cmd.edit(path)
end, { desc = 'Edit Dashboard' })

vim.api.nvim_create_user_command('EditReponotes', function()
	local handle = io.popen(
		[[git remote get-url origin | sed -r 's~(^(http|https|git|ssh|rsync)://)|(.git)$~~g' | sed -r 's~^[^@]+@([^:]+):~\1/~g']]
	)
	assert(handle) -- nil check
	local result = handle:read('*l')
	handle:close()
	vim.cmd.edit(vim.fs.joinpath(doc, 'repo', result, 'index.md'))
end, { desc = 'Edit readinglist.txt' })

vim.api.nvim_create_user_command('EditDailynote', function()
	local path = vim.fs.joinpath(doc, 'daily', os.date('%Y-%m-%d.md'))
	vim.cmd.edit(path)
end, { desc = 'Edit daily note' })

vim.api.nvim_create_user_command('EditSnippet', function()
	local path = vim.fs.joinpath(confroot, 'lua/kjuq/snippet/ft', vim.o.ft .. '.lua')
	vim.cmd.edit(path)
end, { desc = 'Edit snippet' })

-- open specific files via keymaps
vim.keymap.set('n', '<Space>st', '<CMD>EditDashboard<CR>', { desc = 'Edit Dashboard' })
vim.keymap.set('n', '<Space>sr', '<CMD>EditReponotes<CR>', { desc = 'Edit repository specific notes' })
vim.keymap.set('n', '<Space>sd', '<CMD>EditDailynote<CR>', { desc = 'Edit daily note' })
vim.keymap.set('n', '<Space>ss', '<CMD>EditSnippet<CR>', { desc = 'Edit snippet' })
