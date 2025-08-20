-- NOTE: This plugin causes snippets to automatically be expanded unexpectedly

---@module 'lazy'
---@type LazySpec
local spec = { 'https://github.com/andymass/vim-matchup' }
spec.event = 'VeryLazy'

spec.init = function()
	vim.g.matchup_matchparen_enabled = 0
	vim.g.matchup_surround_enabled = 1
	vim.g.matchup_matchparen_deferred_show_delay = 50 -- default: 50
	vim.g.matchup_matchparen_deferred_hide_delay = 700 -- default: 700
	-- vim.g.matchup_matchparen_pumvisible = 0 -- (https://github.com/andymass/vim-matchup/issues/328)
end

spec.opts = {
	treesitter = {
		stopline = 500,
	},
}

spec.config = function(_, opts)
	require('match-up').setup(opts)
	local set_deferred_highlight = function(path, buffer)
		local common = require('kjuq.utils.common')
		if common.is_bigfile(path) or common.is_bigbuf(buffer) then
			vim.b.matchup_matchparen_deferred = 1
		end
	end
	vim.api.nvim_create_autocmd({ 'BufReadPost' }, {
		group = vim.api.nvim_create_augroup('kjuq_matchup_bigfile', {}),
		callback = function(ev)
			set_deferred_highlight(ev.file, ev.buf)
		end,
	})
	-- for lazy-load
	vim.bo.filetype = vim.bo.filetype
	set_deferred_highlight(vim.fn.expand('%'), 0)
end

spec.specs = {
	'nvim-treesitter/nvim-treesitter',
}

return spec
