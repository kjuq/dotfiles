--- @type LazySpec
local spec = { 'vim-denops/denops.vim' }

spec.config = function()
	vim.api.nvim_create_autocmd({ 'User' }, {
		pattern = 'kjuq_denops_activated',
		group = vim.api.nvim_create_augroup('kjuq_denops_activated', {}),
		callback = function() end,
	})
	vim.api.nvim_exec_autocmds('User', { pattern = 'kjuq_denops_activated' })
end

return spec
