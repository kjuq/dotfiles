---@type LazySpec
local spec = { 'rebelot/kanagawa.nvim' }
spec.lazy = _G.kjuq_colorscheme ~= 'kanagawa'
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
	vim.cmd.colorscheme('kanagawa')
end

return spec
