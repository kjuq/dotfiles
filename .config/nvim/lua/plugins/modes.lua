--- @type LazySpec
local spec = { "mvllow/modes.nvim" }

spec.event = { "ModeChanged" }

spec.opts = {
	colors = {
		copy = "#f5c359", -- I have no idea what this it.
		delete = "#c75c6a", -- I have no idea what this it.
		insert = "LightGray",
		visual = "Cyan",
	},
	line_opacity = 0.3, -- Set opacity for cursorline and number background
	set_cursor = true,
	set_cursorline = false,
	set_number = false,
}

return spec
