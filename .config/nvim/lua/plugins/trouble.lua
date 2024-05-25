local map = require("utils.lazy").generate_map("<leader>t", "Trouble: ")

---@type LazySpec
local spec = { "folke/trouble.nvim" }

spec.cmd = {
	"Trouble",
	"TroubleClose",
	"TroubleToggle",
	"TroubleRefresh",
}

spec.keys = {
	map("o", "n", "<CMD>TroubleToggle<CR>", "Toggle"),
	map("w", "n", "<CMD>TroubleToggle workspace_diagnostics<CR>", "Toggle workspace diagnostics"),
	map("d", "n", "<CMD>TroubleToggle document_diagnostics<CR>", "Toggle document diagnostics"),
	map("q", "n", "<CMD>TroubleToggle quickfix<CR>", "Toggle quickfix"),
	map("l", "n", "<CMD>TroubleToggle loclist<CR>", "Toggle loclist"),
	map("r", "n", "<CMD>TroubleToggle lsp_references<CR>", "Toggle lsp references"),
}

spec.opts = {}

spec.dependencies = {
	"nvim-tree/nvim-web-devicons",
}

return spec
