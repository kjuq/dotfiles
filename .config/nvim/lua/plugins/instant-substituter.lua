---@type LazySpec
local spec = { "kjuq/instant-substituter.nvim" }

spec.keys = {
	{ "gz", mode = { "n", "v" } },
}

spec.opts = {
	keys = {
		["gz"] = { "'", '"' },
	},
}

return spec
