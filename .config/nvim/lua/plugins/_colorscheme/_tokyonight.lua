---@module 'lazy'
---@type LazySpec
local spec = { 'https://github.com/folke/tokyonight.nvim' }
spec.lazy = false
spec.priority = 9999

---@type tokyonight.Config
spec.opts = {
	transparent = _G.kjuq_colorscheme_transparent == nil and true or _G.kjuq_colorscheme_transparent,
	dim_inactive = false,
	styles = {
		sidebars = _G.kjuq_colorscheme_transparent,
		floats = _G.kjuq_colorscheme_transparent,
	},
}

return spec
