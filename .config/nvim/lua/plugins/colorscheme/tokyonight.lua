---@type LazySpec
local spec = { 'https://github.com/folke/tokyonight.nvim' }
spec.lazy = not vim.tbl_contains({
	'tokyonight',
	'tokyonight-day',
	'tokyonight-moon',
	'tokyonight-night',
	'tokyonight-storm',
}, _G.kjuq_colorscheme)
spec.priority = 9999

---@type tokyonight.Config
spec.opts = {
	transparent = _G.kjuq_colorscheme_transparent,
	dim_inactive = false,
	styles = {
		sidebars = _G.kjuq_colorscheme_transparent,
		floats = _G.kjuq_colorscheme_transparent,
	},
}

spec.config = function(_, opts)
	require('tokyonight').setup(opts)
	vim.cmd.colorscheme(_G.kjuq_colorscheme)
end

return spec
