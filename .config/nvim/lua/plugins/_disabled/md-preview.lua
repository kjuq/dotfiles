local ft = { 'markdown', 'markdownpreview' }

---@module 'lazy'
---@type LazySpec
local spec = { 'https://github.com/topazape/md-preview.nvim' }
spec.enabled = vim.fn.executable('glow') ~= 0
spec.ft = ft

spec.opts = function()
	vim.api.nvim_create_autocmd({ 'FileType' }, {
		pattern = ft,
		group = vim.api.nvim_create_augroup('kjuq_md_preview', {}),
		callback = function()
			vim.keymap.set('n', 'K', '<Cmd>MPToggle<CR>', { buffer = true, desc = 'Md-preview: Toggle' })
		end,
	})
	return {
		viewer = {
			exec = 'glow',
			exec_path = '',
			args = { '-s', 'dark' },
		},
	}
end

return spec
