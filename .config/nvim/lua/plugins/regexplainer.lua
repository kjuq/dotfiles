---@type LazySpec
local spec = { "bennypowers/nvim-regexplainer" }
spec.event = require("utils.lazy").verylazy

spec.config = function()
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
end

spec.dependencies = {
	"MunifTanjim/nui.nvim",
}

return spec
