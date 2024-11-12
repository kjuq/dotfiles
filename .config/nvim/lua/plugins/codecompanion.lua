---@type LazySpec
local spec = { 'olimorris/codecompanion.nvim' }

local map = require('utils.lazy').generate_map('<leader>c', 'CodeCompanion: ')
spec.keys = {
	map('o', 'n', '<Cmd>CodeCompanionChat<CR>', 'Chat'),
	map('i', 'n', '<Cmd>CodeCompanion<CR>', 'Inline chat'),
	map('a', 'n', '<Cmd>CodeCompanionActions<CR>', 'Actions'),
}

spec.opts = {
	display = {
		chat = {
			window = {
				layout = 'buffer',
			},
			intro_message = '',
		},
	},
	opts = {
		language = 'Japanese',
		send_code = true,
	},
	strategies = {
		chat = {
			adapter = 'copilot',
			keymaps = {
				options = {
					modes = {
						n = 'g?',
					},
				},
				send = {
					modes = {
						n = '<C-g><C-g>',
						i = '<C-g><C-g>',
					},
				},
				regenerate = {
					modes = {
						n = 'gr',
					},
				},
				close = {
					modes = {
						n = '<C-Tab>',
					},
				},
				stop = {
					modes = {
						n = '<C-q>',
					},
				},
				clear = {
					modes = {
						n = 'gx',
					},
				},
				codeblock = {
					modes = {
						n = 'gc',
					},
				},
				yank_code = {
					modes = {
						n = 'gy',
					},
				},
				next_chat = {
					modes = {
						n = ']}',
					},
				},
				previous_chat = {
					modes = {
						n = '[{',
					},
				},
				next_header = {
					modes = {
						n = ']]',
					},
				},
				previous_header = {
					modes = {
						n = '[[',
					},
				},
				change_adapter = {
					modes = {
						n = 'ga',
					},
				},
				fold_code = {
					modes = {
						n = 'gf',
					},
				},
				debug = {
					modes = {
						n = 'gd',
					},
				},
				system_prompt = {
					modes = {
						n = 'gs',
					},
				},
			},
		},
		inline = {
			adapter = 'copilot',
			keymaps = {
				accept_change = {
					modes = {
						n = 'ga',
					},
					index = 1,
					callback = 'keymaps.accept_change',
					description = 'Accept change',
				},
				reject_change = {
					modes = {
						n = 'gr',
					},
					index = 2,
					callback = 'keymaps.reject_change',
					description = 'Reject change',
				},
			},
		},
	},
}

spec.specs = {
	'nvim-lua/plenary.nvim',
	'nvim-treesitter/nvim-treesitter',
}

spec.dependencies = {
	-- 'hrsh7th/nvim-cmp', -- Optional: For using slash commands and variables in the chat buffer
	-- 'nvim-telescope/telescope.nvim', -- Optional: For using slash commands
	{ 'MeanderingProgrammer/render-markdown.nvim', ft = { 'markdown', 'codecompanion' } }, -- Optional: For prettier markdown rendering
	{ 'stevearc/dressing.nvim', opts = {} }, -- Optional: Improves `vim.ui.select`
}

return spec
