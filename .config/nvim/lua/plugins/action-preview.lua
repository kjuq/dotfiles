local map = require("utils.lazy").generate_map("", "Action-preview: ")

return {
	"aznhe21/actions-preview.nvim",
	keys = {
		map("<M-f>", { "n", "x" }, function() require("actions-preview").code_actions() end, "Open"),
	},
	dependencies = {
		"MunifTanjim/nui.nvim",
	},
}
