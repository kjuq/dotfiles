-- `set background=light` will load `kanagawa-lotus`
-- Don't use `colorscheme kanagawa-lotus`

---@module 'lazy'
---@type LazySpec
local spec = { 'https://github.com/rebelot/kanagawa.nvim' }
spec.lazy = false
spec.priority = 9999

spec.opts = {
	transparent = _G.kjuq.colorscheme_transparent == nil and true or _G.kjuq.colorscheme_transparent,
	dimInactive = true, -- dim inactive window `:h hl-NormalNC`
	theme = 'wave', -- Load "wave" theme when 'background' option is not set
	background = { -- map the value of 'background' option to a theme
		dark = 'wave', -- try "dragon" !
		light = 'lotus',
	},
}

spec.config = function(_, opts)
	require('kanagawa').setup(opts) -- `setup` must be called before loading
	vim.cmd.colorscheme('kanagawa')
end

return spec
