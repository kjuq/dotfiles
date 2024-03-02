local map = require("utils.lazy").generate_map("<leader>g", "Git-conflict: ")

---@type LazySpec
local spec = { "akinsho/git-conflict.nvim" }
spec.version = "*"

spec.cmd = {
	"GitConflictChooseOurs",
	"GitConflictChooseTheirs",
	"GitConflictChooseBoth",
	"GitConflictChooseNone",
	"GitConflictNextConflict",
	"GitConflictPrevConflict",
	"GitConflictListQf",
}

spec.keys = {
	map("c", "n", "<cmd>GitConflictListQf<CR>", "List in Quickfix"),
}

spec.opts = {}

return spec
