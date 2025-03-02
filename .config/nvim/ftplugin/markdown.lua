vim.g.markdown_recommended_style = false
vim.opt_local.wrap = true

vim.keymap.set('n', '<Space>aP', function()
	require('kjuq.utils.ft.markdown').open_marp(0)
end, { desc = 'Open Marp slide' })

vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
	group = vim.api.nvim_create_augroup('kjuq_markdown_compile_marp_on_save', {}),
	callback = function()
		require('kjuq.utils.ft.markdown').compile_marp(0)
	end,
	buffer = 0,
})
