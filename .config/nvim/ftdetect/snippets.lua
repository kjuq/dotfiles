vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
	pattern = '*.snippets',
	group = vim.api.nvim_create_augroup('kjuq_snippets', {}),
	callback = function()
		vim.opt_local.filetype = 'snippets'
	end,
})
