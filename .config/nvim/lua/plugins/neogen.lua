local map = require("utils.lazy").generate_map("gcd", "Neogen: ")

---@type LazySpec
local spec = { "danymat/neogen" }
spec.lazy = false

spec.keys = {
	map("f", "n", function()
		require("neogen").generate({ type = "func" })
	end, "Generate annotation of function"),
	map("t", "n", function()
		require("neogen").generate({ type = "type" })
	end, "Generate annotation of type"),
	map("c", "n", function()
		require("neogen").generate({ type = "class" })
	end, "Generate annotation of class"),
	map("h", "n", function()
		require("neogen").generate({ type = "file" })
	end, "Generate annotation of header"),
}

spec.opts = {
	snippet_engine = "luasnip",
	enable_placeholders = false,
}

spec.dependencies = { "nvim-treesitter/nvim-treesitter" }

return spec
