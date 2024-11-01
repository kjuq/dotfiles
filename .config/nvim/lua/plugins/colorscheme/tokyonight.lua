---@type LazySpec
local spec = { 'folke/tokyonight.nvim' }
spec.lazy = false
spec.priority = 9999

spec.opts = {
	transparent = true,
	dim_inactive = false,
	styles = {
		sidebars = 'transparent', -- "dark", "transparent", "normal"
		floats = 'transparent', -- "dark", "transparent", "normal"
	},
}

spec.config = function(_, opts)
	require('tokyonight').setup(opts)
	vim.cmd.colorscheme('tokyonight')
	vim.api.nvim_set_hl(0, 'WinSeparator', { fg = 'DarkGray' })
	vim.api.nvim_set_hl(0, 'StatusLine', { bg = 'NONE', ctermbg = 'NONE' })
	vim.api.nvim_set_hl(0, 'StatusLineNC', { bg = 'NONE', ctermbg = 'NONE' })
	-- vim.api.nvim_set_hl(0, "Pmenu", { bg = "#000000", ctermbg = "NONE" })
end

return spec
