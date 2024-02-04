return {
	"andymass/vim-matchup",
	event = require("utils.lazy").verylazy,
	config = function()
		require("nvim-treesitter.configs").setup({
			matchup = {
				enable = true,
				enable_quotes = true,
			},
		})
		-- for lazy-load, reload filetype
		vim.bo.filetype = vim.bo.filetype
	end,
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
}
