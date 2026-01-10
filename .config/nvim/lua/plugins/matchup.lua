-- NOTE: This plugin causes snippets to automatically be expanded unexpectedly
-- TODO: Lazy load

---@module 'lazy'
---@type LazySpec
local spec = { 'https://github.com/andymass/vim-matchup' }
spec.lazy = false

spec.init = function()
	vim.g.matchup_matchparen_enabled = 0 -- highlight matched paren
	vim.g.matchup_surround_enabled = 1
	vim.g.matchup_matchparen_offscreen = { method = 'popup' }
	-- vim.g.matchup_matchparen_pumvisible = 0 -- (https://github.com/andymass/vim-matchup/issues/328)
end

spec.config = function()
	require('match-up').setup({
		---@diagnostic disable-next-line: missing-fields
		treesitter = {
			stopline = 500,
		},
	})
end

spec.specs = {
	'nvim-treesitter/nvim-treesitter',
}

return spec
