---@module 'lazy'
---@type LazySpec
local spec = { 'https://github.com/folke/tokyonight.nvim' }
spec.lazy = false
spec.priority = 9999

---@type tokyonight.Config
spec.opts = {
	transparent = _G.kjuq.colorscheme_transparent == nil and true or _G.kjuq.colorscheme_transparent,
	dim_inactive = false,
	styles = {
		sidebars = _G.kjuq.colorscheme_transparent,
		floats = _G.kjuq.colorscheme_transparent,
	},
}

spec.config = function(_, opts)
	require('tokyonight').setup(opts) -- `setup` must be called before loading
	vim.cmd.colorscheme('tokyonight')
end

return spec
