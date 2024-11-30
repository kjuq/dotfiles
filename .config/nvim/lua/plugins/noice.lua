local map = require('utils.lazy').generate_map('', '')

local utils = require('utils.common')

---@type LazySpec
local spec = { 'folke/noice.nvim' }

spec.event = 'VeryLazy'

spec.cmd = { 'Noice' }

spec.keys = {
	map(utils.floatscrolldown, { 'n', 'i' }, function()
		require('noice.lsp').scroll(4)
	end, 'Page down'),
	map(utils.floatscrollup, { 'n', 'i' }, function()
		require('noice.lsp').scroll(-4)
	end, 'Page up'),
}

spec.opts = {
	cmdline = {
		format = {
			lua = false,
			help = false,
			filter = false,
		},
		opts = {
			border = { style = require('utils.common').floatwinborder },
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
		progress = {
			enabled = false,
		},
		hover = {
			enabled = true,
		},
		signature = {
			enabled = true,
			auto_open = { enabled = false },
		},
		documentation = {
			opts = {
				border = require('utils.common').floatwinborder,
				position = { row = 2, col = 2 },
				size = {
					max_width = require('utils.lsp').float_max_width,
					max_height = require('utils.lsp').float_max_height,
				},
			},
		},
	},
	views = {
		cmdline_popup = {
			position = {
				row = -1,
			},
		},
		hover = {
			scrollbar = true,
		},
		mini = {
			timeout = 3000, -- ms
			reverse = false,
			position = {
				row = 2,
				col = -2,
			},
			border = {
				style = require('utils.common').floatwinborder,
			},
			win_options = {
				winblend = 0,
			},
		},
	},
	routes = {
		{
			-- To suppress Copilot error
			-- https://github.com/zbirenbaum/copilot.lua/issues/321#issuecomment-2459000453
			filter = {
				event = 'msg_show',
				any = {
					{ find = 'Agent service not initialized' },
				},
			},
			opts = { skip = true },
		},
	},
}

spec.specs = {
	'MunifTanjim/nui.nvim',
}

return spec
