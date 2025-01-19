Kjuq_hl_todo_ids = {}

vim.api.nvim_create_autocmd({ 'WinEnter', 'BufRead', 'BufNew', 'Syntax' }, {
	pattern = '*',
	group = vim.api.nvim_create_augroup('kjuq_highlight_todo', {}),
	callback = function()
		Kjuq_hl_todo_ids[#Kjuq_hl_todo_ids + 1] = vim.fn.matchadd(
			'Todo',
			[[\v\W \zs(TODO|FIXME|CHANGED|XXX|BUG|HACK|NOTE|INFO|IDEA):]] -- `\v` to avoid too much backslashes (very magic)
		)
	end,
})
