-- This plugin may be incompatible with nvim-cmp
-- See: https://github.com/tzachar/highlight-undo.nvim/issues/2

---@type LazySpec
local spec = { 'tzachar/highlight-undo.nvim' }

spec.keys = {
	{ 'u', mode = 'n' },
	{ '<C-r>', mode = 'n' },
}

spec.opts = {
	duration = require('kjuq.utils.common').highlight_duration,
	undo = {
		hlgroup = 'HighlightUndo',
		mode = 'n',
		lhs = 'u',
		map = 'undo',
		opts = {},
	},
	redo = {
		hlgroup = 'HighlightUndo',
		mode = 'n',
		lhs = '<C-r>',
		map = 'redo',
		opts = {},
	},
	highlight_for_count = true,
}

return spec
