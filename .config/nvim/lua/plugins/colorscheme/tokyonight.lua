---@type LazySpec
local spec = { 'folke/tokyonight.nvim' }
spec.lazy = _G.kjuq_colorscheme ~= 'tokyonight'
spec.priority = 9999

---@type table|fun(LazyPlugin, opts:table):tokyonight.Config
spec.opts = function(_, opts)
	local t = (_G.kjuq_colorscheme_transparent or _G.kjuq_colorscheme_transparent == nil) and 'transparent' or 'normal'
	return {
		transparent = t,
		dim_inactive = false,
		styles = {
			sidebars = t, -- "dark", "transparent", "normal"
			floats = t, -- "dark", "transparent", "normal"
		},
	}
end

spec.config = function(_, opts)
	require('tokyonight').setup(opts)
	vim.cmd.colorscheme('tokyonight')
end

return spec
