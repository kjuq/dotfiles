vim.api.nvim_create_autocmd({ 'QuickFixCmdPost' }, {
	group = vim.api.nvim_create_augroup('kjuq_auto_copen', {}),
	callback = function()
		vim.cmd.redraw() -- not to show hit-enter prompt
		vim.cmd.copen()
		vim.schedule(function()
			vim.cmd.copen() -- focus quickfix window
		end)
	end,
})
