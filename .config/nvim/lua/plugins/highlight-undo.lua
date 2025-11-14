-- This plugin may be incompatible with nvim-cmp
-- See: https://github.com/tzachar/highlight-undo.nvim/issues/2

---@module 'lazy'
---@type LazySpec
local spec = { 'https://github.com/tzachar/highlight-undo.nvim' }

spec.lazy = false

spec.opts = {
	duration = require('kjuq.utils.helper').highlight_duration,
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
