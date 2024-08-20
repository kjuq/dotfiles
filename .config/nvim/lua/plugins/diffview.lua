local map = require('utils.lazy').generate_map('<leader>g', 'Diffview: ')

---@type LazySpec
local spec = { 'sindrets/diffview.nvim' }

spec.cmd = {
	'DiffviewOpen',
	'DiffviewFileHistory',
	'DiffviewClose',
	'DiffviewFocusFiles',
	'DiffviewToggleFiles',
	'DiffviewRefresh',
	'DiffviewLog',
}

spec.keys = {
	map('o', 'n', '<CMD>DiffviewOpen<CR>', 'Open'),
	map('l', 'n', '<CMD>DiffviewFileHistory %<CR>', 'File History'),
}

spec.config = function()
	vim.api.nvim_create_autocmd({ 'FileType' }, {
		pattern = { 'DiffviewFileHistory', 'DiffviewFiles' },
		group = vim.api.nvim_create_augroup('kjuq_diff_view', {}),
		callback = function()
			vim.keymap.set('n', '<leader>q', function()
				vim.cmd('DiffviewClose')
			end, { buffer = true })
		end,
	})
end

return spec
