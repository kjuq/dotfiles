---@type LazySpec
local spec = {
	"yutkat/wb-only-current-line.nvim",
	keys = {
		{ "w", mode = { "n", "x" } },
		{ "b", mode = { "n", "x" } },
	},
}

return spec
