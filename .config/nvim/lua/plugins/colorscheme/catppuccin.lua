---@type LazySpec
local spec = { 'https://github.com/catppuccin/nvim' }
spec.name = 'catppuccin'
spec.lazy = not vim.tbl_contains({
	'catppuccin',
	'catppuccin-latte',
	'catppuccin-mocha',
	'catppuccin-frappe',
	'catppuccin-macchiato',
}, _G.kjuq_colorscheme)
spec.priority = 9999

spec.opts = {
	flavour = 'mocha', -- latte, frappe, macchiato, mocha
	background = { -- :h background
		light = 'latte',
		dark = 'mocha',
	},
	transparent_background = _G.kjuq_colorscheme_transparent == nil and true or _G.kjuq_colorscheme_transparent,
	dim_inactive = {
		enabled = false, -- dims the background color of inactive window
		shade = 'dark',
		percentage = 0.15, -- percentage of the shade to apply to the inactive window
	},
	styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
		comments = { 'italic' }, -- Change the style of comments
		conditionals = { 'italic' },
		loops = {},
		functions = {},
		keywords = { 'italic' },
		strings = {},
		variables = {},
		numbers = {},
		booleans = {},
		properties = {},
		types = {},
		operators = {},
	},
}

spec.config = function(_, opts)
	require('catppuccin').setup(opts) -- `setup` must be called before loading
	vim.cmd.colorscheme(_G.kjuq_colorscheme)
	vim.api.nvim_set_hl(0, 'LineNr', { fg = '#888888' })
end

return spec
