---@type LazySpec
local spec = { "EdenEast/nightfox.nvim" }
spec.lazy = false
spec.priority = 9999

spec.config = function()
	require("nightfox").setup({
		options = {
			transparent = false, -- imperfect
			dim_inactive = true, -- Non focused panes set to alternative background
		},
	})
	vim.cmd.colorscheme("nightfox")
	vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#808080" })
end

return spec
