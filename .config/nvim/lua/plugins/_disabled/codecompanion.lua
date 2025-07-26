---@type LazySpec
local spec = { 'https://github.com/olimorris/codecompanion.nvim' }

spec.cmd = {
	'CodeCompanion',
	'CodeCompanionChat',
	'CodeCompanionActions',
	'CodeCompanionCmd',
}

local map = require('kjuq.utils.lazy').generate_map('', 'CodeCompanion: ')
spec.keys = {
	map('<Space>cO', { 'n', 'x' }, '<Cmd>CodeCompanionChat Toggle<CR>', 'Chat'),
	map('<C-w><Space>cO', { 'n', 'x' }, '<Cmd>vsplit | CodeCompanionChat Toggle<CR>', 'Chat'),
	map('<Space>ci', { 'n' }, '<Cmd>CodeCompanion<CR>', 'Inline chat'),
	map('<Space>ca', { 'n', 'x' }, '<Cmd>CodeCompanionActions<CR>', 'Actions'),
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
	adapters = {
		copilot = function()
			return require('codecompanion.adapters').extend('copilot', {
				schema = {
					model = {
						default = 'claude-3.5-sonnet',
					},
				},
			})
		end,
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
						n = '<Space>cR',
					},
				},
				close = {
					modes = {
						n = '<Space>cX',
					},
				},
				stop = {
					modes = {
						n = '<Space>cq',
					},
				},
				clear = {
					modes = {
						n = '<Space>cC',
					},
				},
				codeblock = {
					modes = {
						n = '<Nop>',
					},
				},
				yank_code = {
					modes = {
						n = '<Nop>',
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
						n = '<Space>cA',
					},
				},
				fold_code = {
					modes = {
						n = '<Nop>',
					},
				},
				debug = {
					modes = {
						n = '<Space>cD',
					},
				},
				system_prompt = {
					modes = {
						n = '<Space>cS',
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
				},
				reject_change = {
					modes = {
						n = 'gr',
					},
				},
			},
		},
	},
}

spec.config = function(_, opts)
	require('codecompanion').setup(opts)

	vim.api.nvim_create_autocmd({ 'FileType' }, {
		pattern = 'codecompanion',
		group = vim.api.nvim_create_augroup('kjuq_codecompanion', {}),
		callback = function()
			local toggle_map = function(key)
				vim.keymap.set(
					'n',
					key,
					'<Cmd>CodeCompanionChat Toggle<CR>',
					{ desc = 'Codecompanion: Toggle', buffer = true }
				)
			end
			toggle_map('<C-Tab>')
			toggle_map('<C-S-Tab>')
		end,
	})
end

spec.specs = {
	'nvim-lua/plenary.nvim',
	'nvim-treesitter/nvim-treesitter',
	'nvim-telescope/telescope.nvim', -- Optional: For using slash commands
}

spec.dependencies = {
	'hrsh7th/nvim-cmp', -- Optional: For using slash commands and variables in the chat buffer
}

return spec
