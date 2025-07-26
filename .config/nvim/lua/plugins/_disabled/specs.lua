-- NOTE: Buggy when using with Japanese letters

---@type LazySpec
local spec = { 'https://github.com/cxwx/specs.nvim' }

-- TODO: load on keypresses that potentially jump long
spec.event = 'VeryLazy'

spec.opts = function()
	return {
		show_jumps = true,
		min_jump = 2,
		popup = {
			delay_ms = 0,
			inc_ms = 10,
			blend = 0,
			width = 15,
			winhl = 'kjuq_highlight_on_yank',
			fader = require('specs').linear_fader,
			resizer = require('specs').shrink_resizer,
		},
		ignore_buftypes = {
			nofile = true,
		},
	}
end

return spec
