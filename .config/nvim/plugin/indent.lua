-- show indent line implemented with built-in functionality
local update_indent_line = function()
	vim.opt_local.listchars:append({ leadmultispace = '╎' .. string.rep('⋅', vim.bo.tabstop - 1) })
end
vim.api.nvim_create_autocmd({ 'OptionSet' }, {
	pattern = { 'listchars', 'tabstop', 'filetype' },
	group = vim.api.nvim_create_augroup('kjuq_update_indent_line', {}),
	callback = update_indent_line,
})
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
	group = vim.api.nvim_create_augroup('kjuq_init_indent_line', {}),
	callback = update_indent_line,
})
