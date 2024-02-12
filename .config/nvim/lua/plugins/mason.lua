local cmap = require("utils.lazy").generate_cmd_map("<leader>", "Mason: ")

---@type LazySpec
local spec = { "williamboman/mason.nvim" }

spec.keys = { cmap("al", "n", "Mason", "Open") }

spec.opts = {
	ui = {
		border = require("utils.lazy").floatwinborder,
	},
}

return spec
