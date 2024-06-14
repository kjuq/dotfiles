local map = require("utils.lazy").generate_map("", "Action-preview: ")

---@type LazySpec
local spec = { "aznhe21/actions-preview.nvim" }

spec.keys = {
	map("crr", { "n", "x" }, function()
		require("actions-preview").code_actions()
	end, "Open"),
}

spec.dependencies = {
	"MunifTanjim/nui.nvim",
}

return spec
