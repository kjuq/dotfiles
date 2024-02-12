local map = require("utils.lazy").generate_cmd_map("<leader>t", "Trouble: ")

---@type LazySpec
local spec = { "folke/trouble.nvim" }

spec.cmd = {
	"Trouble",
	"TroubleClose",
	"TroubleToggle",
	"TroubleRefresh",
}

spec.keys = {
	map("t", "n", "TroubleToggle", "Toggle"),
	map("w", "n", "TroubleToggle workspace_diagnostics", "Toggle workspace diagnostics"),
	map("d", "n", "TroubleToggle document_diagnostics", "Toggle document diagnostics"),
	map("q", "n", "TroubleToggle quickfix", "Toggle quickfix"),
	map("l", "n", "TroubleToggle loclist", "Toggle loclist"),
	map("r", "n", "TroubleToggle lsp_references", "Toggle lsp references"),
}

spec.opts = {}

spec.dependencies = {
	"nvim-tree/nvim-web-devicons",
}

return spec
