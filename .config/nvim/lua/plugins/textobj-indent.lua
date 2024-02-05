-- These keymaps are defined by default
-- ai: <Plug>(textobj-indent-a)
-- ii: <Plug>(textobj-indent-i)
-- aI: <Plug>(textobj-indent-same-a)
-- iI: <Plug>(textobj-indent-same-i)

---@type LazySpec
local spec = {
	"kana/vim-textobj-indent",
	keys = {
		{ "i", mode = "" },
		{ "a", mode = "" },
	},
	dependencies = {
		"kana/vim-textobj-user",
	},
}

return spec
