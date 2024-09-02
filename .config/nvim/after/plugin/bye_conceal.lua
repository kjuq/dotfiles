vim.api.nvim_create_autocmd({ 'FileType' }, {
	pattern = '*',
	callback = function()
		vim.opt_local.conceallevel = 0
	end,
})
