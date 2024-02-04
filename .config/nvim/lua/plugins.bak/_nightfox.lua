---@type LazySpec
local spec = {
	"EdenEast/nightfox.nvim",
	lazy = false,
	priority = 9999,
	config = function()
		require('nightfox').setup({
			options = {
				transparent = false, -- imperfect
				dim_inactive = true, -- Non focused panes set to alternative background
			},
		})
		vim.cmd.colorscheme("nightfox")
		vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#808080" })
	end,
}

return spec
