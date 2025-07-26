-- `set background=light` will load `kanagawa-lotus`
-- Don't use `colorscheme kanagawa-lotus`

---@type LazySpec
local spec = { 'https://github.com/rebelot/kanagawa.nvim' }
spec.lazy = not vim.tbl_contains({
	'kanagawa',
	'kanagawa-wave',
	'kanagawa-lotus',
	'kanagawa-dragon',
}, _G.kjuq_colorscheme)
spec.priority = 9999

spec.opts = {
	transparent = _G.kjuq_colorscheme_transparent == nil and true or _G.kjuq_colorscheme_transparent,
	dimInactive = true, -- dim inactive window `:h hl-NormalNC`
	theme = 'wave', -- Load "wave" theme when 'background' option is not set
	background = { -- map the value of 'background' option to a theme
		dark = 'wave', -- try "dragon" !
		light = 'lotus',
	},
}

spec.config = function(_, opts)
	require('kanagawa').setup(opts)
	vim.cmd.colorscheme(_G.kjuq_colorscheme)
end

return spec
