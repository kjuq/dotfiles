---@type LazySpec
local spec = { "andymass/vim-matchup" }
spec.event = require("utils.lazy").verylazy

spec.config = function()
	---@diagnostic disable-next-line: missing-fields
	require("nvim-treesitter.configs").setup({
		matchup = {
			enable = true,
			enable_quotes = true,
			disable_virtual_text = true,
		},
	})
	-- for lazy-load, reload filetype
	vim.bo.filetype = vim.bo.filetype
end

spec.dependencies = {
	"nvim-treesitter/nvim-treesitter",
}

return spec
