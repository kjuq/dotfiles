---@type LazySpec
local spec = { 'thinca/vim-qfreplace' }

spec.ft = 'qf'

spec.config = function()
	vim.g.qfreplace_no_save = 1
	vim.api.nvim_create_autocmd({ 'FileType' }, {
		pattern = 'qf',
		group = vim.api.nvim_create_augroup('kjuq_qfreplace', {}),
		callback = function()
			vim.keymap.set('n', 'r', '<Cmd>Qfreplace<CR>', { buffer = true })
		end,
	})
end

return spec
