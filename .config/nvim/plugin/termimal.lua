vim.api.nvim_create_autocmd({ 'BufEnter', 'TermOpen' }, {
	group = vim.api.nvim_create_augroup('kjuq_terminal_rc', {}),
	callback = function()
		if vim.bo.buftype ~= 'terminal' then
			return
		end
		vim.cmd.startinsert()
	end,
})
