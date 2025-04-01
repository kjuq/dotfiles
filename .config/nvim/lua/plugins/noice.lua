---@type LazySpec
local spec = { 'folke/noice.nvim' }

spec.event = 'VeryLazy'

spec.cmd = { 'Noice' }

spec.opts = {
	cmdline = {
		format = {
			lua = false,
			help = false,
			filter = false,
		},
		opts = {
			border = { style = vim.o.winborder },
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
		enabled = false,
	},
	lsp = {
		progress = {
			enabled = false,
		},
		hover = {
			enabled = false,
		},
		signature = {
			enabled = true,
			auto_open = { enabled = false },
		},
		documentation = {
			opts = {
				border = require('kjuq.utils.common').floatwinborder,
				position = { row = 2, col = 2 },
				size = {
					-- max_width = require('kjuq.utils.lsp').float_max_width,
					-- max_height = require('kjuq.utils.lsp').float_max_height,
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
				style = require('kjuq.utils.common').floatwinborder,
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
