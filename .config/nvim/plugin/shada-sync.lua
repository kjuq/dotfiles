local group = vim.api.nvim_create_augroup('kjuq_shada_sync', {})

vim.api.nvim_create_autocmd({ 'TextYankPost', 'FocusLost', 'CmdlineLeave' }, {
	group = group,
	callback = function()
		vim.cmd.wshada()
	end,
})

vim.api.nvim_create_autocmd({ 'FocusGained', 'CmdLineEnter' }, {
	group = group,
	callback = function()
		vim.cmd.rshada()
	end,
})
