-- quit with esc in command-line window
vim.api.nvim_create_autocmd({ 'CmdwinEnter' }, { -- q:
	group = vim.api.nvim_create_augroup('kjuq_esccmdwin', {}),
	callback = function()
		vim.keymap.set('n', '<Esc>', vim.cmd.quit, { buffer = true })
	end,
})
