---@type LazySpec
local spec = { 'https://github.com/b0o/incline.nvim' }
spec.event = 'VeryLazy'

spec.opts = {
	highlight = {
		groups = {
			InclineNormal = {
				default = true,
				group = 'Error',
			},
			InclineNormalNC = {
				default = true,
				group = 'Error',
			},
		},
	},
	window = {
		margin = {
			horizontal = 0,
			vertical = 0,
		},
		overlap = {
			borders = true,
			statusline = false,
			tabline = false,
			winbar = true,
		},
	},
}

return spec
