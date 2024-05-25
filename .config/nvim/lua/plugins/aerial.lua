local map = require("utils.lazy").generate_map("", "Aerial: ")

---@type LazySpec
local spec = { "stevearc/aerial.nvim" }

spec.keys = {
	map("gO", "n", "<CMD>AerialToggle<CR>", "Toggle"),
}

spec.opts = {
	backends = { "lsp", "treesitter", "markdown", "man" },
	keymaps = {
		["<Esc>"] = "actions.close",
	},
	show_guides = true,
}

spec.dependencies = {
	"nvim-treesitter/nvim-treesitter",
	"nvim-tree/nvim-web-devicons",
}

return spec
