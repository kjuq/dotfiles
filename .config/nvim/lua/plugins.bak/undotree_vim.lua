local map = require("utils.lazy").generate_map("", "Undotree: ")

---@type LazySpec
local spec = { "mbbill/undotree" }

spec.cmd = {
	"UndotreeToggle",
	"UndotreeHide",
	"UndotreeShow",
	"UndotreeFocus",
	"UndotreePersistUndo",
}

spec.keys = {
	map("<leader>au", "n", "<Cmd>UndotreeToggle<CR>", "Toggle"),
}

return spec
