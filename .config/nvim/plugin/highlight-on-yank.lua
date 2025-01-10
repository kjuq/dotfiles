local group = vim.api.nvim_create_augroup('kjuq_highlight_on_yank', {})

local set_hl = function()
	vim.api.nvim_set_hl(0, 'kjuq_highlight_on_yank', { bg = '#c43963' }) -- color is from SagaBeacon of LspSaga
end
vim.api.nvim_create_autocmd({ 'ColorScheme' }, {
	group = group,
	callback = set_hl,
})

local highlight = function()
	local timeout = require('kjuq.utils.common').highlight_duration
	require('vim.hl').on_yank({ higroup = 'kjuq_highlight_on_yank', timeout = timeout })
end
vim.api.nvim_create_autocmd({ 'TextYankPost' }, {
	group = group,
	callback = highlight,
})

set_hl()
