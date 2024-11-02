---@type LazySpec
local spec = { 'kjuq/instant-substituter.nvim' }

spec.keys = {
	{ 'gz', mode = { 'n', 'x' } },
}

spec.opts = {
	keys = {
		['gz'] = { "'", '"' },
	},
}

return spec
