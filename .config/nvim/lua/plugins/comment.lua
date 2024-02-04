---@type LazySpec
local spec = {
	"numToStr/Comment.nvim",
	keys = {
		{ "gc", mode = { "n", "x" }, desc = "Comment: add line comment", },
		{ "gb", mode = { "n", "x" }, desc = "Comment: add block comments", },
	},
	opts = {},
}

return spec
