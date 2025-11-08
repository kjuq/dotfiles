---@module 'lazy'
---@type LazySpec
local spec = { 'https://github.com/ellisonleao/gruvbox.nvim' }
spec.lazy = false
spec.priority = 9999

spec.opts = {
	transparent_mode = _G.kjuq_colorscheme_transparent == nil and true or _G.kjuq_colorscheme_transparent,
	dim_inactive = false,
}

return spec
