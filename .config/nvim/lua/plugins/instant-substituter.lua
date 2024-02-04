---@type LazySpec
local spec = {
	"kjuq/instant-substituter.nvim",
	keys = {
		{ "gz", mode = { "n", "v" } },
	},
	opts = {
		keys = {
			["gz"] = { "'", '"' },
		},
	},
}

return spec
