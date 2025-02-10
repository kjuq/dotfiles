if Kjuq_plugin_disabled and Kjuq_plugin_disabled.highlight_todo then
	return
end

vim.api.nvim_create_autocmd({ 'WinEnter', 'BufRead', 'BufNew', 'Syntax' }, {
	pattern = '*',
	group = vim.api.nvim_create_augroup('kjuq_highlight_todo', {}),
	callback = function()
		vim.fn.matchadd(
			'Todo',
			[[\v\W \zs(TODO|FIXME|CHANGED|XXX|BUG|HACK|NOTE|INFO|IDEA):]] -- `\v` to avoid too much backslashes (very magic)
		)
	end,
})
