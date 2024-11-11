local callback = function()
	local line = vim.fn.line([['"]])
	local btmline = vim.api.nvim_buf_line_count(0)
	local ignore_fts = {
		'commit',
		'gitrebase',
		'xxd',
	}
	if line < 1 or line > btmline or vim.tbl_contains(ignore_fts, vim.o.filetype) then
		return
	end
	vim.cmd([[normal! g`"zz]])
end

vim.api.nvim_create_autocmd({ 'BufEnter' }, {
	group = vim.api.nvim_create_augroup('kjuq_restore_cursor', {}),
	callback = callback,
})
