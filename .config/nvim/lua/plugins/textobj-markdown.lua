---@type LazySpec
local spec = {
	"christoomey/vim-textobj-codeblock",
	keys = {
		{ "i", mode = "" },
		{ "a", mode = "" },
	},
	dependencies = {
		"kana/vim-textobj-user",
	},
}

-- ic: Contents of the codeblock
-- ac: Entire codeblock, including backtick lines

return spec
