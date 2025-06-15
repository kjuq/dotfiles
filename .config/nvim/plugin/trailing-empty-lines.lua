vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
	group = vim.api.nvim_create_augroup('kjuq_trailing_empty_lines', {}),
	callback = require('kjuq.utils.edit').delete_trailing_empty_lines,
})
