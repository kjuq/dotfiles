-- Buggy when switching buffer with opened quickfix window

---@type LazySpec
local spec = {
	"stevearc/stickybuf.nvim",
	lazy = false,
	event = "WinEnter",
	opts = {},
}

return spec
