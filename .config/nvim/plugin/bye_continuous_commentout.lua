vim.api.nvim_create_autocmd({ 'BufEnter' }, {
	callback = function()
		vim.opt_local.formatoptions:remove('r')
		vim.opt_local.formatoptions:remove('o')
	end,
})
