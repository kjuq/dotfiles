local map = require("utils.lazy").generate_map("", "")

local utils = require("utils.common")
local scrollup = utils.floatscrollup
local scrolldown = utils.floatscrolldown

---@type LazySpec
local spec = { "folke/noice.nvim" }

spec.event = require("utils.lazy").verylazy

spec.cmd = { "Noice" }

spec.keys = {
	map("gA", "n", "<CMD>Noice<CR>", "Noice"),
	map(scrolldown, { "n", "i" }, function()
		if not require("noice.lsp").scroll(4) then
			return scrolldown
		end
	end, "Page down", { expr = true }),
	map(scrollup, { "n", "i" }, function()
		if not require("noice.lsp").scroll(-4) then
			return scrollup
		end
	end, "Page up", { expr = true }),
}

spec.opts = function()
	require("utils.common").quit_with_esc("noice")
	return {
		cmdline = {
			format = {
				lua = false,
				help = false,
			},
			opts = {
				border = { style = require("utils.common").floatwinborder },
			},
		},
		messages = {
			enabled = true,
			view_search = false,
		},
		popupmenu = { -- Noice's completion
			enabled = false,
		},
		notify = {
			enabled = true,
		},
		lsp = {
			progress = { enabled = true },
			hover = { enabled = true },
			signature = {
				enabled = true,
				auto_open = { enabled = false },
			},
			documentation = {
				opts = {
					border = require("utils.common").floatwinborder,
					position = { row = 2, col = 2 },
					size = {
						max_width = require("core.lsp").float_max_width,
						max_height = require("core.lsp").float_max_height,
					},
				},
			},
		},
		views = {
			hover = {
				scrollbar = false,
			},
		},
	}
end

spec.dependencies = {
	"MunifTanjim/nui.nvim",
}

return spec
