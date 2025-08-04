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
local pro = 'gemini_pro'
local default_adapter = pro

-- NOTE: This article shows usecases
-- https://minerva.mamansoft.net/2025-03-21-codecompanion-neovim-ai-coding#%E5%AE%9F%E9%9A%9B%E3%81%AE%E9%96%8B%E7%99%BA%E3%81%A7%E3%82%88%E3%81%8F%E4%BD%BF%E3%81%86%E3%83%A6%E3%83%BC%E3%82%B9%E3%82%B1%E3%83%BC%E3%82%B9

local map = require('kjuq.utils.lazy').generate_map('', 'CodeCompanion: ')
spec.keys = {
	map('<Space>po', 'n', string.format('<Cmd>CodeCompanionChat %s Toggle<CR><Cmd>only<CR>', pro), 'Pro model'),
	map('<Space>po', 'x', string.format(':CodeCompanionChat %s<CR><Cmd>only<CR>', pro), 'Pro model'),

	map('<Space>pO', 'n', string.format('<Cmd>CodeCompanionChat %s Toggle<CR>', pro), 'Pro model in split'),
	map('<Space>pO', 'x', string.format(':CodeCompanionChat %s<CR>', pro), 'Pro model in split'),

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
				name = 'gemini_pro',
				formatted_name = 'Gemini Pro',
				env = { api_key = 'cmd:pass google.com/gemini_api_key' },
				schema = {
					model = { default = 'gemini-2.5-pro' },
				},
			})
		end,
		gemini_flash_lite = function()
			return require('codecompanion.adapters').extend('gemini', {
				name = 'gemini_flash_lite',
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
					modes = { n = '<Nop>' },
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
		'https://github.com/j-hui/fidget.nvim',
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
	{
		'https://github.com/ravitemer/codecompanion-history.nvim',
		keys = {
			{ '<Space>ph', mode = 'n', '<Cmd>CodeCompanionHistory<CR>' },
		},
		config = function()
			local plugopts = {
				keymap = '<Nop>', -- Keymap to open history from chat buffer (default: gh)
				save_chat_keymap = '<Nop>', -- Keymap to save the current chat manually (when auto_save is disabled)
				auto_save = true, -- Save all chats by default (disable to save only manually using 'sc')
				expiration_days = 0, -- Number of days after which chats are automatically deleted (0 to disable)
				picker = nil, --- "telescope", "snacks", "fzf-lua", or "default" (`nil` to auto resolve to a valid picker)
				chat_filter = nil, ---@type function(chat_data) return boolean | Filter function to control which chats are shown
				picker_keymaps = { -- Customize picker keymaps (optional)
					rename = { n = 'r', i = '<M-r>' },
					delete = { n = 'd', i = '<M-d>' },
					duplicate = { n = '<M-y>', i = '<M-y>' },
				},
				auto_generate_title = true, ---Automatically generate titles for new chats
				title_generation_opts = {
					adapter = nil, ---Adapter for generating titles (`nil` to current chat adapter) "copilot"
					model = nil, ---Model for generating titles (`nil` to current chat model) "gpt-4o"
					refresh_every_n_prompts = 0, -- Number of prompts after which to refresh the title
					max_refreshes = 3, ---Maximum number of times to refresh the title (default: 3)
					format_title = function(original_title)
						-- this can be a custom function that applies some custom formatting to the title.
						return original_title
					end,
				},
				continue_last_chat = false, -- On exiting and entering neovim, loads the last chat on opening chat
				delete_on_clearing_chat = false, -- When chat is cleared with `gx` delete the chat from history
				dir_to_save = vim.fn.stdpath('data') .. '/codecompanion-history', -- Directory path to save the chats
				enable_logging = false, -- Enable detailed logging for history extension

				summary = { -- Summary system
					create_summary_keymap = '<Nop>', -- Keymap to generate summary for current chat (default: "gcs")
					browse_summaries_keymap = '<Nop>', -- Keymap to browse summaries (default: "gbs")

					generation_opts = {
						adapter = nil, -- defaults to current chat adapter
						model = nil, -- defaults to current chat model
						context_size = 90000, -- max tokens that the model supports
						include_references = true, -- include slash command content
						include_tool_outputs = true, -- include tool execution results
						system_prompt = nil, -- custom system prompt (string or function)
						format_summary = nil, -- custom function to format generated summary e.g to remove <think/> tags from summary
					},
				},

				memory = { -- Memory system (requires VectorCode CLI)
					auto_create_memories_on_summary_generation = true, -- Automatically index summaries when they are generated
					vectorcode_exe = 'vectorcode', -- Path to the VectorCode executable
					tool_opts = { -- Tool configuration
						default_num = 10, -- Default number of memories to retrieve
					},
					notify = true, -- Enable notifications for indexing progress
					index_on_startup = false, -- Index existing memories on startup (needs VectorCode 0.6.12+ for efficiency)
				},
			}

			local opts = spec.opts --[[@ as table]]
			opts = vim.tbl_deep_extend('error', opts, {
				extensions = { history = { enabled = true, opts = plugopts } },
			})
			require('codecompanion').setup(opts)
		end,
	},
}

return spec
