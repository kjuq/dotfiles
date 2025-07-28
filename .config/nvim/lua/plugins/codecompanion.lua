---@type LazySpec
local spec = { 'https://github.com/olimorris/codecompanion.nvim' }

spec.cmd = {
	'CodeCompanion',
	'CodeCompanionChat',
	'CodeCompanionActions',
	'CodeCompanionCmd',
}

local pfx = '<Space>p'

-- adopters
local light = 'gemini_flash_lite'
local pro = 'gemini_pro'
local default_adapter = pro

-- NOTE: This article shows usecases
-- https://minerva.mamansoft.net/2025-03-21-codecompanion-neovim-ai-coding#%E5%AE%9F%E9%9A%9B%E3%81%AE%E9%96%8B%E7%99%BA%E3%81%A7%E3%82%88%E3%81%8F%E4%BD%BF%E3%81%86%E3%83%A6%E3%83%BC%E3%82%B9%E3%82%B1%E3%83%BC%E3%82%B9

local map = require('kjuq.utils.lazy').generate_map('', 'CodeCompanion: ')
spec.keys = {
	map('<Space>pO', 'n', string.format('<Cmd>CodeCompanionChat %s Toggle<CR><Cmd>only<CR>', light), 'Light model'),
	map('<Space>pO', 'x', string.format(':CodeCompanionChat %s<CR><Cmd>only<CR>', light), 'Light model'),

	map('<Space>po', 'n', string.format('<Cmd>CodeCompanionChat %s Toggle<CR>', light), 'Light model in split'),
	map('<Space>po', 'x', string.format(':CodeCompanionChat %s<CR>', light), 'Light model in split'),

	map('<Space>pM', 'n', string.format('<Cmd>CodeCompanionChat %s Toggle<CR><Cmd>only<CR>', pro), 'Pro model'),
	map('<Space>pM', 'x', string.format(':CodeCompanionChat %s<CR><Cmd>only<CR>', pro), 'Pro model'),

	map('<Space>pm', 'n', string.format('<Cmd>CodeCompanionChat %s Toggle<CR>', pro), 'Pro model in split'),
	map('<Space>pm', 'x', string.format(':CodeCompanionChat %s<CR>', pro), 'Pro model in split'),

	map('<Space>pi', 'n', '<Cmd>CodeCompanion<CR>', 'Inline chat'),
	map('<Space>pi', 'x', ':CodeCompanion<CR>', 'Inline chat'),

	map('<Space>pa', 'n', '<Cmd>CodeCompanionActions<CR>', 'Actions'),
	map('<Space>pa', 'x', ':CodeCompanionActions<CR>', 'Actions'),

	map('<Space>pe', 'n', '<Cmd>%CodeCompanion /explain<CR>', 'Explain'),
	map('<Space>pe', 'x', ':CodeCompanion /explain<CR>', 'Explain'),

	map('<Space>pd', 'n', '<Cmd>%CodeCompanion /lsp<CR>', 'LSP diagnostics'),
	map('<Space>pd', 'x', ':CodeCompanion /lsp<CR>', 'LSP diagnostics'),
}

spec.opts = {
	display = {
		chat = {
			window = {
				layout = 'vertical', -- float|vertical|horizontal|buffer
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
		gemini_pro = function()
			return require('codecompanion.adapters').extend('gemini', {
				formatted_name = 'Gemini Pro',
				env = { api_key = 'cmd:pass google.com/gemini_api_key' },
				schema = {
					model = { default = 'gemini-2.5-pro' },
				},
			})
		end,
		gemini_flash_lite = function()
			return require('codecompanion.adapters').extend('gemini', {
				formatted_name = 'Gemini Flash-Lite',
				env = { api_key = 'cmd:pass google.com/gemini_api_key' },
				schema = {
					model = { default = 'gemini-2.5-flash-lite' },
				},
			})
		end,
	},
	strategies = {
		chat = {
			adapter = default_adapter,
			keymaps = {
				options = {
					modes = { n = 'g?' },
				},
				completion = {
					modes = { i = '<C-x><C-a>' },
				},
				send = {
					modes = { n = '<C-g><C-g>', i = '<C-g><C-g>' },
				},
				regenerate = {
					modes = { n = pfx .. 'R' },
				},
				close = {
					modes = { n = '<Space>x', i = '<Nop>' },
				},
				stop = {
					modes = { n = pfx .. 'Q' },
				},
				clear = {
					modes = { n = pfx .. 'C' },
				},
				codeblock = {
					modes = { n = '<Nop>' },
				},
				yank_code = {
					modes = { n = '<Nop>' },
				},
				pin = {
					modes = { n = pfx .. 'P' },
				},
				watch = {
					modes = { n = pfx .. 'W' },
				},
				next_chat = {
					modes = { n = ']}' },
				},
				previous_chat = {
					modes = { n = '[{' },
				},
				next_header = {
					modes = { n = ']]' },
				},
				previous_header = {
					modes = { n = '[[' },
				},
				change_adapter = {
					modes = { n = pfx .. 'A' },
				},
				fold_code = {
					modes = { n = '<Nop>' },
				},
				debug = {
					modes = { n = pfx .. 'D' },
				},
				system_prompt = {
					modes = { n = pfx .. 'S' },
				},
				auto_tool_mode = {
					modes = { n = '<Nop>' },
				},
				goto_file_under_cursor = {
					modes = { n = '<Nop>' },
				},
				copilot_stats = {
					modes = { n = pfx .. 'C' },
				},
			},
		},
		inline = {
			adapter = default_adapter,
			keymaps = {
				accept_change = {
					modes = { n = pfx .. 'Y' },
				},
				reject_change = {
					modes = { n = pfx .. 'N' },
				},
			},
		},
		cmd = {
			adapter = default_adapter,
		},
	},
}

spec.config = function(_, opts)
	require('codecompanion').setup(opts)

	vim.api.nvim_create_autocmd('FileType', {
		pattern = 'codecompanion',
		group = vim.api.nvim_create_augroup('kjuq_codecompanion_keymap_for_close', {}),
		callback = function()
			local toggle_map = function(key)
				-- vim.keymap.set( 'n', key, '<Cmd>CodeCompanionChat Toggle<CR>', { desc = 'Codecompanion: Toggle', buffer = true })
				vim.keymap.set('n', key, '<Cmd>bnext<CR>', { desc = ':bnext', buffer = true })
			end
			toggle_map('<C-Tab>')
			toggle_map('<C-S-Tab>')
		end,
	})

	vim.api.nvim_create_autocmd('User', {
		pattern = 'CodeCompanionChatSubmitted',
		group = vim.api.nvim_create_augroup('kjuq_codecompanion_submitted', {}),
		desc = 'Exit insert mode after submitting a prompt',
		callback = function()
			if string.sub(vim.api.nvim_get_mode().mode, 1, 1) ~= 'i' then
				return
			end
			vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 'n', false)
		end,
	})
end

spec.specs = {
	'nvim-lua/plenary.nvim',
	'nvim-treesitter/nvim-treesitter',
}

spec.dependencies = {
	{
		'j-hui/fidget.nvim',
		config = function(_, opts)
			-- https://github.com/olimorris/codecompanion.nvim/discussions/813#discussioncomment-12031954
			local progress = require('fidget.progress')
			local handles = {}

			local function store_progress_handle(id, handle)
				handles[id] = handle
			end

			local function pop_progress_handle(id)
				local handle = handles[id]
				handles[id] = nil
				return handle
			end

			local function llm_role_title(adapter)
				local parts = {}
				table.insert(parts, adapter.formatted_name)
				if adapter.model and adapter.model ~= '' then
					table.insert(parts, '(' .. adapter.model .. ')')
				end
				return table.concat(parts, ' ')
			end

			local function create_progress_handle(request)
				return progress.handle.create({
					title = ' Requesting assistance (' .. request.data.strategy .. ')',
					message = 'In progress...',
					lsp_client = {
						name = llm_role_title(request.data.adapter),
					},
				})
			end

			local function report_exit_status(handle, request)
				if request.data.status == 'success' then
					handle.message = 'Completed'
				elseif request.data.status == 'error' then
					handle.message = ' Error'
				else
					handle.message = '󰜺 Cancelled'
				end
			end

			local function init()
				local group = vim.api.nvim_create_augroup('CodeCompanionFidgetHooks', {})
				vim.api.nvim_create_autocmd({ 'User' }, {
					pattern = 'CodeCompanionRequestStarted',
					group = group,
					callback = function(request)
						local handle = create_progress_handle(request)
						store_progress_handle(request.data.id, handle)
					end,
				})
				vim.api.nvim_create_autocmd({ 'User' }, {
					pattern = 'CodeCompanionRequestFinished',
					group = group,
					callback = function(request)
						local handle = pop_progress_handle(request.data.id)
						if handle then
							report_exit_status(handle, request)
							handle:finish()
						end
					end,
				})
			end

			init()
			require('fidget').setup(opts)
		end,
	},
}

return spec
