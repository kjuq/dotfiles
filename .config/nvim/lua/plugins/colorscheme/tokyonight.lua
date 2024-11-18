---@type LazySpec
local spec = { 'folke/tokyonight.nvim' }
spec.lazy = _G.kjuq_colorscheme ~= 'tokyonight'
spec.priority = 9999

---@class tokyonight.Config
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
end

return spec
