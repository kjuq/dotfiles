return {
	"bennypowers/nvim-regexplainer",
	event = require("utils.lazy").verylazy,
	config = function()
		require("regexplainer").setup({
			auto = true,
			mappings = {
				toggle = "<Nop>", -- disable gR which is the default keymap
			},
			popup = {
				border = {
					padding = { 0, 1 },
					style = require("utils.lazy").floatwinborder,
				}
			}
		})
	end,
	dependencies = {
		"MunifTanjim/nui.nvim",
	},
}
