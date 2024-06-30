local map = require("utils.lazy").generate_map("", "Undotree: ")

---@type LazySpec
local spec = { "jiaoshijie/undotree" }

spec.dependencies = { "nvim-lua/plenary.nvim" }

spec.opts = {
	window = {
		winblend = 0,
	},
}

spec.keys = {
	map("<leader>au", "n", function()
		require("undotree").toggle()
	end, "Toggle"),
}

return spec
