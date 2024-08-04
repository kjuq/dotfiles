---@type LazySpec
local spec = { "akinsho/git-conflict.nvim" }

spec.version = "*"

spec.event = "VeryLazy"

local map = require("utils.lazy").generate_map("", "Git-conflict: ")
spec.keys = {
	map("<leader>gcl", "n", "<Cmd>GitConflictListQf<CR>", "List QuickFix"),
	map("<leader>gc]", "n", "<Cmd>GitConflictChooseTheirs<CR>", "Choose theirs"),
	map("<leader>gc[", "n", "<Cmd>GitConflictChooseOurs<CR>", "Choose ours"),
	map("<leader>gc=", "n", "<Cmd>GitConflictChooseBoth<CR>", "Choose both"),
	map("<leader>gc-", "n", "<Cmd>GitConflictChooseNone<CR>", "Choose none"),
	map("<leader>gc_", "n", "<Cmd>GitConflictChooseBase<CR>", "Choose base"),
	map("]c", "n", "<Cmd>GitConflictNextConflict<CR>", "Next conflict"),
	map("[c", "n", "<Cmd>GitConflictPrevConflict<CR>", "Previous conflict"),
}

spec.opts = function()
	vim.notify("Git-conflict: Conflict detected")
	return {}
end

return spec
