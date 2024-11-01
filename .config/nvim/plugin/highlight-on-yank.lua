local callback = function()
	local timeout = require('utils.common').highlight_duration
	require('vim.hl').on_yank({ higroup = 'kjuq_highlight_on_yank', timeout = timeout })
end

vim.api.nvim_set_hl(0, 'kjuq_highlight_on_yank', { bg = '#c43963' }) -- color is from SagaBeacon of LspSaga
vim.api.nvim_create_autocmd({ 'TextYankPost' }, {
	group = vim.api.nvim_create_augroup('kjuq_highlight_on_yank', {}),
	callback = callback,
})
