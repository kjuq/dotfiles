---@type LazySpec
local spec = { "ibhagwan/smartyank.nvim" }
spec.event = { "BufReadPost" }

spec.opts = {
	highlight = {
		enabled = false,
	},
	clipboard = {
		enabled = false,
	},
	osc52 = {
		silent = true,
	},
	validate_yank = false,
}

return spec
