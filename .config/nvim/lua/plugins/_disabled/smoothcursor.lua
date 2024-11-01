---@type LazySpec
local spec = { 'gen740/SmoothCursor.nvim' }
spec.event = { 'CursorMoved', 'CursorMovedI' }

spec.opts = {
	fancy = {
		enable = true,
	},
}

return spec
