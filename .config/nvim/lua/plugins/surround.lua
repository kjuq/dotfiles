---@type LazySpec
local spec = { "kylechui/nvim-surround" }
spec.version = "*" -- Use for stability; omit to use `main` branch for the latest features

spec.keys = {
	{ "ys", mode = { "n" } },
	{ "ds", mode = { "n" } },
	{ "cs", mode = { "n" } },
	{ "y",  mode = { "x" } },
	{ "d",  mode = { "x" } },
	{ "c",  mode = { "x" } },
}

spec.opts = {}

spec.dependencies = {
	"nvim-treesitter/nvim-treesitter",
	"nvim-treesitter/nvim-treesitter-textobjects",
}

return spec
