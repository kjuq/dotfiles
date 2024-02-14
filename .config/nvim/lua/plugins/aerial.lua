local map = require("utils.lazy").generate_cmd_map("", "Aerial: ")

---@type LazySpec
local spec = { "stevearc/aerial.nvim" }

spec.keys = {
	map("gO", "n", "AerialToggle", "Toggle"),
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
