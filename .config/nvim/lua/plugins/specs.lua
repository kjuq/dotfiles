---@type LazySpec
local spec = { "cxwx/specs.nvim" }

-- TODO: load on keypresses that potentially jump long
spec.event = "VeryLazy"

spec.opts = function()
	return {
		show_jumps = true,
		min_jump = 2,
		popup = {
			delay_ms = 0,
			inc_ms = 10,
			blend = 0,
			width = 15,
			winhl = "UserHighlightOnYank",
			fader = require("specs").linear_fader,
			resizer = require("specs").shrink_resizer,
		},
		ignore_buftypes = {
			nofile = true,
		},
	}
end

return spec
