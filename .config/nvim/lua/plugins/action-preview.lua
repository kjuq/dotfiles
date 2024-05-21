local map = require("utils.lazy").generate_map("", "Action-preview: ")

---@type LazySpec
local spec = { "aznhe21/actions-preview.nvim" }

spec.keys = {
	map("crr", "n", function()
		require("actions-preview").code_actions()
	end, "Open"),
	map("<C-r>r", "x", function()
		require("actions-preview").code_actions()
	end, "Open"),
	map("<C-r><C-r>", "x", function()
		require("actions-preview").code_actions()
	end, "Open"),
}

spec.dependencies = {
	"MunifTanjim/nui.nvim",
}

return spec
