---@module 'lazy'
---@type LazySpec
local spec = { 'https://github.com/olimorris/codecompanion.nvim' }

spec.cmd = {
	'CodeCompanion',
	'CodeCompanionChat',
	'CodeCompanionActions',
	'CodeCompanionCmd',
}

local pfx = '<Space>p'

local default_adp = 'copilot'

-- NOTE: This article shows usecases
-- https://minerva.mamansoft.net/2025-03-21-codecompanion-neovim-ai-coding#%E5%AE%9F%E9%9A%9B%E3%81%AE%E9%96%8B%E7%99%BA%E3%81%A7%E3%82%88%E3%81%8F%E4%BD%BF%E3%81%86%E3%83%A6%E3%83%BC%E3%82%B9%E3%82%B1%E3%83%BC%E3%82%B9

local map = require('kjuq.lazy').generate_map('', 'CodeCompanion: ')
spec.keys = {
	map('<Space>po', { 'n', 'x' }, string.format('<Cmd>CodeCompanionChat adapter=%s<CR>', default_adp), 'Open'),
	map(
		'<Space>pO',
		{ 'n', 'x' },
		string.format('<Cmd>vsplit | CodeCompanionChat adapter=%s<CR>', default_adp),
		'Split'
	),
	map('<Space>pa', { 'n', 'x' }, '<Cmd>CodeCompanionActions<CR>', 'Actions'),

	map('<Space>pe', 'n', '<Cmd>vsplit | %CodeCompanion /explain<CR>', 'Explain'),
	map('<Space>pe', 'x', '<Cmd>vsplit | CodeCompanion /explain<CR>', 'Explain'),

	map('<Space>pd', 'n', '<Cmd>vsplit | %CodeCompanion /lsp<CR>', 'LSP diagnostics'),
	map('<Space>pd', 'x', '<Cmd>vsplit | CodeCompanion /lsp<CR>', 'LSP diagnostics'),
}

spec.opts = {
	ignore_warnings = true,
	display = {
		chat = {
			window = {
				layout = 'buffer', -- float|vertical|horizontal|buffer
				width = 0.5,
				opts = {
					linebreak = false,
				},
			},
			intro_message = '',
		},
	},
	opts = {
		language = 'Japanese',
		send_code = true,
	},
	adapters = {
		acp = {
			opts = {
				show_defaults = false,
			},
			claude_code = function()
				return require('codecompanion.adapters').extend('claude_code', {
					env = {
						CLAUDE_CODE_OAUTH_TOKEN = 'cmd:pass claude.ai/main | head -n1',
					},
				})
			end,
			gemini_cli = function()
				return require('codecompanion.adapters').extend('gemini_cli', {
					defaults = {
						auth_method = 'oauth-personal', -- "oauth-personal"|"gemini-api-key"|"vertex-ai"
					},
					-- env = {
					-- 	GEMINI_API_KEY = 'cmd:op read op://personal/Gemini_API/credential --no-newline',
					-- },
				})
			end,
		},
		http = {
			opts = {
				show_defaults = false,
			},
			copilot = function()
				return require('codecompanion.adapters').extend('copilot', {
					schema = {
						model = {
							default = 'claude-sonnet-4.5', -- 'claude-opus-4.5'
						},
					},
				})
			end,
		},
	},
	strategies = {
		chat = {
			adapter = default_adp,
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
					modes = { n = '<Space>x', i = nil },
				},
				stop = {
					modes = { n = pfx .. 'Q' },
				},
				clear = {
					modes = { n = pfx .. 'C' },
				},
				codeblock = {
					modes = { n = nil },
				},
				yank_code = {
					modes = { n = nil },
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
					modes = { n = nil },
				},
				debug = {
					modes = { n = pfx .. 'D' },
				},
				system_prompt = {
					modes = { n = nil },
				},
				goto_file_under_cursor = {
					modes = { n = nil },
				},
				copilot_stats = {
					modes = { n = pfx .. 'C' },
				},
			},
		},
		inline = {
			adapter = default_adp,
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
			adapter = default_adp,
		},
	},
}

spec.config = function(_, opts)
	require('codecompanion').setup(opts)
	vim.api.nvim_create_autocmd('FileType', {
		pattern = 'codecompanion',
		group = vim.api.nvim_create_augroup('kjuq_codecompanion_buf_setting', {}),
		callback = function()
			-- vim.bo.bufhidden = 'wipe'
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
	{ 'nvim-lua/plenary.nvim' },
}

-- spec.dependencies = {
-- 	{
-- 		'https://github.com/ravitemer/codecompanion-history.nvim',
-- 		keys = {
-- 			{ '<Space>ph', mode = 'n', '<Cmd>CodeCompanionHistory<CR>', desc = 'CodeCompanion-history: Open' },
-- 		},
-- 		config = function()
-- 			local plugopts = {
-- 				keymap = '<Nop>', -- Keymap to open history from chat buffer (default: gh)
-- 				save_chat_keymap = '<Nop>', -- Keymap to save the current chat manually (when auto_save is disabled)
-- 				auto_save = true, -- Save all chats by default (disable to save only manually using 'sc')
-- 				expiration_days = 0, -- Number of days after which chats are automatically deleted (0 to disable)
-- 				picker = nil, --- "telescope", "snacks", "fzf-lua", or "default" (`nil` to auto resolve to a valid picker)
-- 				chat_filter = nil, ---@type function(chat_data) return boolean | Filter function to control which chats are shown
-- 				picker_keymaps = { -- Customize picker keymaps (optional)
-- 					rename = { n = 'r', i = '<M-r>' },
-- 					delete = { n = 'd', i = '<M-d>' },
-- 					duplicate = { n = '<M-y>', i = '<M-y>' },
-- 				},
-- 				auto_generate_title = true, ---Automatically generate titles for new chats
-- 				title_generation_opts = {
-- 					adapter = 'copilot', ---Adapter for generating titles (`nil` to current chat adapter) "copilot"
-- 					model = nil, ---Model for generating titles (`nil` to current chat model) "gpt-4o"
-- 					refresh_every_n_prompts = 0, -- Number of prompts after which to refresh the title
-- 					max_refreshes = 3, ---Maximum number of times to refresh the title (default: 3)
-- 					format_title = function(original_title)
-- 						-- this can be a custom function that applies some custom formatting to the title.
-- 						return original_title
-- 					end,
-- 				},
-- 				continue_last_chat = false, -- On exiting and entering neovim, loads the last chat on opening chat
-- 				delete_on_clearing_chat = false, -- When chat is cleared with `gx` delete the chat from history
-- 				dir_to_save = vim.fn.stdpath('data') .. '/codecompanion-history', -- Directory path to save the chats
-- 				enable_logging = false, -- Enable detailed logging for history extension
-- 				summary = { -- Summary system
-- 					create_summary_keymap = '<Nop>', -- Keymap to generate summary for current chat (default: "gcs")
-- 					browse_summaries_keymap = '<Nop>', -- Keymap to browse summaries (default: "gbs")
-- 					generation_opts = {
-- 						adapter = nil, -- defaults to current chat adapter
-- 						model = nil, -- defaults to current chat model
-- 						context_size = 90000, -- max tokens that the model supports
-- 						include_references = true, -- include slash command content
-- 						include_tool_outputs = true, -- include tool execution results
-- 						system_prompt = nil, -- custom system prompt (string or function)
-- 						format_summary = nil, -- custom function to format generated summary e.g to remove <think/> tags from summary
-- 					},
-- 				},
-- 				memory = { -- Memory system (requires VectorCode CLI)
-- 					auto_create_memories_on_summary_generation = true, -- Automatically index summaries when they are generated
-- 					vectorcode_exe = 'vectorcode', -- Path to the VectorCode executable
-- 					tool_opts = { -- Tool configuration
-- 						default_num = 10, -- Default number of memories to retrieve
-- 					},
-- 					notify = true, -- Enable notifications for indexing progress
-- 					index_on_startup = false, -- Index existing memories on startup (needs VectorCode 0.6.12+ for efficiency)
-- 				},
-- 			}
-- 			local opts = spec.opts --[[@ as table]]
-- 			opts = vim.tbl_deep_extend('error', opts, {
-- 				extensions = { history = { enabled = true, opts = plugopts } },
-- 			})
-- 			require('codecompanion').setup(opts)
-- 		end,
-- 	},
-- 	{
-- 		'https://github.com/j-hui/fidget.nvim',
-- 		config = function(_, opts)
-- 			-- https://github.com/olimorris/codecompanion.nvim/discussions/813#discussioncomment-12031954
-- 			local progress = require('fidget.progress')
-- 			local handles = {}
-- 			local function store_progress_handle(id, handle)
-- 				handles[id] = handle
-- 			end
-- 			local function pop_progress_handle(id)
-- 				local handle = handles[id]
-- 				handles[id] = nil
-- 				return handle
-- 			end
-- 			local function llm_role_title(adapter)
-- 				local parts = {}
-- 				table.insert(parts, adapter.formatted_name)
-- 				if adapter.model and adapter.model ~= '' then
-- 					table.insert(parts, '(' .. adapter.model .. ')')
-- 				end
-- 				return table.concat(parts, ' ')
-- 			end
-- 			local function create_progress_handle(request)
-- 				return progress.handle.create({
-- 					title = ' Requesting assistance (' .. request.data.strategy .. ')',
-- 					message = 'In progress...',
-- 					lsp_client = {
-- 						name = llm_role_title(request.data.adapter),
-- 					},
-- 				})
-- 			end
-- 			local function report_exit_status(handle, request)
-- 				if request.data.status == 'success' then
-- 					handle.message = 'Completed'
-- 				elseif request.data.status == 'error' then
-- 					handle.message = ' Error'
-- 				else
-- 					handle.message = '󰜺 Cancelled'
-- 				end
-- 			end
-- 			local function init()
-- 				local group = vim.api.nvim_create_augroup('CodeCompanionFidgetHooks', {})
-- 				vim.api.nvim_create_autocmd({ 'User' }, {
-- 					pattern = 'CodeCompanionRequestStarted',
-- 					group = group,
-- 					callback = function(request)
-- 						local handle = create_progress_handle(request)
-- 						store_progress_handle(request.data.id, handle)
-- 					end,
-- 				})
-- 				vim.api.nvim_create_autocmd({ 'User' }, {
-- 					pattern = 'CodeCompanionRequestFinished',
-- 					group = group,
-- 					callback = function(request)
-- 						local handle = pop_progress_handle(request.data.id)
-- 						if handle then
-- 							report_exit_status(handle, request)
-- 							handle:finish()
-- 						end
-- 					end,
-- 				})
-- 			end
-- 			init()
-- 			require('fidget').setup(opts)
-- 		end,
-- 	},
-- }

return spec
