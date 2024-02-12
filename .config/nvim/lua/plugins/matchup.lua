---@type LazySpec
local spec = { "andymass/vim-matchup" }
spec.event = require("utils.lazy").verylazy

spec.config = function()
	require("nvim-treesitter.configs").setup({
		matchup = {
			enable = true,
			enable_quotes = true,
		},
	})
	-- for lazy-load, reload filetype
	vim.bo.filetype = vim.bo.filetype
end

spec.dependencies = {
	"nvim-treesitter/nvim-treesitter",
	"nvim-treesitter/nvim-treesitter-textobjects",
}

return spec
