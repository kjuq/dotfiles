---@type LazySpec
local spec = { "ibhagwan/smartyank.nvim" }
spec.event = "BufReadPost"

spec.opts = {
	highlight = {
		enabled = false,
	},
	osc52 = {
		silent = false,
	},
}

return spec
