--- @type LazySpec
local spec = { 'vim-denops/denops.vim' }

spec.config = function()
	vim.api.nvim_create_autocmd({ 'User' }, {
		pattern = 'UserDenopsActivated',
		group = vim.api.nvim_create_augroup('user_denops_activated', {}),
		callback = function() end,
	})
	vim.api.nvim_exec_autocmds('User', { pattern = 'UserDenopsActivated' })
end

return spec
