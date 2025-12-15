local map = require('kjuq.utils.lazy').generate_map('<Space>a', 'CCC: ')

---@module 'lazy'
---@type LazySpec
local spec = { 'https://github.com/uga-rosa/ccc.nvim' }
spec.event = 'VeryLazy'

spec.cmd = {
	'CccPick',
	'CccConvert',
	'CccHighlighterEnable',
	'CccHighlighterDisable',
	'CccHighlighterToggle',
}

spec.config = function()
	require('ccc').setup()

	local enable_hl = function(path, buffer)
		local common = require('kjuq.utils.helper')
		if common.is_bigfile(path) or common.is_bigbuf(buffer) then
			return
		end
		vim.cmd('CccHighlighterEnable')
	end
	enable_hl(vim.fn.expand('%'), 0)

	vim.api.nvim_create_autocmd({ 'BufEnter' }, {
		group = vim.api.nvim_create_augroup('kjuq_ccc_highlighter_auto_enable', {}),
		callback = function(ev)
			enable_hl(ev.file, ev.buf)
		end,
	})
end

return spec
