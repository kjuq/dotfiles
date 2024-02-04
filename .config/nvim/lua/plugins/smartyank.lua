---@type LazySpec
local spec = {
	"ibhagwan/smartyank.nvim",
	event = "BufReadPost",
	opts = {
		highlight = {
			enabled = false,
		},
		osc52 = {
			silent = false,
		},
	},
}

return spec
