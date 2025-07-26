---@type LazySpec
local spec = { 'https://github.com/gen740/SmoothCursor.nvim' }
spec.event = { 'CursorMoved', 'CursorMovedI' }

spec.opts = {
	fancy = {
		enable = true,
	},
}

return spec
