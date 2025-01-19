---@type LazySpec
local spec = { 'kjuq/instant-substituter.nvim' }

spec.keys = {
	{ '<Space>cq', mode = { 'n', 'x' }, desc = [[Instant-substituter: ' -> " ]] },
}

spec.opts = {
	keys = {
		['<Space>cq'] = { "'", '"' },
	},
}

return spec
