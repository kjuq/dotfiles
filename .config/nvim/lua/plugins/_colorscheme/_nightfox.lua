---@module 'lazy'
---@type LazySpec
local spec = { 'https://github.com/EdenEast/nightfox.nvim' }
spec.lazy = false
spec.priority = 9999

spec.opts = {
	options = {
		transparent = _G.kjuq_colorscheme_transparent == nil and true or _G.kjuq_colorscheme_transparent,
		dim_inactive = false, -- Non focused panes set to alternative background
	},
}

return spec
