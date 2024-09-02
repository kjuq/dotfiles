vim.api.nvim_create_autocmd({ 'FileType' }, {
	pattern = '*',
	callback = function()
		vim.opt_local.formatoptions:remove('r')
		vim.opt_local.formatoptions:remove('o')
	end,
})
