vim.api.nvim_create_autocmd({ 'BufWinEnter' }, {
	callback = function()
		vim.opt_local.shiftwidth = 0
	end,
})
