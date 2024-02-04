---@type LazySpec
local spec = {
	"antosha417/nvim-lsp-file-operations",
	event = { "LspAttach" },
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-neo-tree/neo-tree.nvim",
		"stevearc/oil.nvim",
	},
	config = function()
		require("lsp-file-operations").setup()
	end,
}

return spec
