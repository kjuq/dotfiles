---@type LazySpec
local spec = {
	"kana/vim-textobj-entire",
	keys = {
		{ "i", mode = "" },
		{ "a", mode = "" },
	},
	dependencies = {
		"kana/vim-textobj-user",
	},
}

return spec
