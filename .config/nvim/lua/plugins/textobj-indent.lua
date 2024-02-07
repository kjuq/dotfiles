-- These keymaps are defined by default
-- ai: <Plug>(textobj-indent-a)
-- ii: <Plug>(textobj-indent-i)
-- aI: <Plug>(textobj-indent-same-a)
-- iI: <Plug>(textobj-indent-same-i)

local map = require("utils.lazy").generate_map("", "Textobj-indent: ")

---@type LazySpec
local spec = {
	"kana/vim-textobj-indent",
	keys = {
		map("aI", { "x", "o" }, "<Plug>(textobj-indent-a)", "Around"),
		map("iI", { "x", "o" }, "<Plug>(textobj-indent-i)", "Inner"),
	},
	init = function()
		vim.g.textobj_indent_no_default_key_mappings = false
	end,
	dependencies = {
		"kana/vim-textobj-user",
	},
}

return spec
