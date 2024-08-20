vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
	pattern = { '*.log', '*_log', '.LOG', '_LOG' },
	group = vim.api.nvim_create_augroup('kjuq_detectft_log', {}),
	callback = function()
		vim.opt_local.filetype = 'log'
	end,
})
