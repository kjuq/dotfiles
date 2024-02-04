local map = require("utils.lazy").generate_map("", "TreeSJ: ")

---@type LazySpec
local spec = {
	"Wansmer/treesj",
	keys = {
		map("<leader>ak", "n", function() require("treesj").toggle() end, "Toggle")
	},
	config = function()
		require("treesj").setup({
			use_default_keymaps = false,
		})
	end,
	dependencies = { "nvim-treesitter/nvim-treesitter" },
}

return spec
