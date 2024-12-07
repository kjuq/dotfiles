---@type LazySpec
local spec = { 'robitx/gp.nvim' }

spec.cmd = {
	'GpChatNew',
	'GpChatPaste',
	'GpChatToggle',
	'GpChatFinder',
	'GpRewrite',
	'GpAppend',
	'GpPrepend',
	'GpEnew',
	'GpNew',
	'GpVnew',
	'GpPopup',
	'GpImplement',
	'GpContext',
	'GpNextAgent',
	'GpAgent',
	'GpImage',
	'GpImageAgent',
}

local map = require('utils.lazy').generate_map('', 'GP: ')
spec.keys = {
	map('<Space>po', 'n', '<CMD>GpChatToggle<CR>', 'Open chat'),
	map('<C-w><Space>po', 'n', '<CMD>GpChatToggle vsplit<CR>', 'Open chat'),
	map('<Space>pr', 'n', '<CMD>GpRewrite<CR>', 'Open prompt to rewrite codes'),
	map('<Space>py', 'x', '<CMD>GpChatPaste<CR>', 'Paste selected text to a chat'),
	map('<Space>pj', 'n', '<CMD>GpAppend<CR>', 'Open prompt to append codes'),
	map('<Space>pk', 'n', '<CMD>GpPrepend<CR>', 'Open prompt to prepend codes'),

	map('<Space>px', 'n', '<CMD>GpContext<CR>', 'Configure custom context per repo'),

	map('<Space>pn', 'n', '<CMD>GpChatNew<CR>', 'Open new chat'),
}

---@type GpConfig
spec.opts = {
	-- chat_dir = os.getenv("HOME") .. "/documents/chatgpt",
	providers = {
		openai = {
			secret = { 'pass', 'openai.com/api_key' },
		},
		copilot = {
			disable = false,
			-- Secret is automatically fetched with `copilot.vim`
			-- `$XDG_CONFIG_HOME/github-copilot/hosts.json`
		},
	},

	agents = {
		{
			name = 'ChatCopilot-Claude',
			provider = 'copilot',
			chat = true,
			command = false,
			model = { model = 'claude-3.5-sonnet', temperature = 1.1, top_p = 1 },
			system_prompt = require('utils.ai').system_prompt('Japanese'),
		},
		{
			name = 'ChatCopilot-GPT4o',
			provider = 'copilot',
			chat = true,
			command = false,
			model = { model = 'gpt-4o', temperature = 1.1, top_p = 1 },
			system_prompt = require('utils.ai').system_prompt('Japanese'),
		},
		{
			-- Unable to use `o1-mini` due to the error: `Bad request`
			name = 'ChatCopilot-GPT4o-mini',
			provider = 'copilot',
			chat = true,
			command = false,
			model = { model = 'o1-mini', temperature = 1.1, top_p = 1 },
			system_prompt = require('utils.ai').system_prompt('Japanese'),
		},
	},

	default_chat_agent = 'ChatCopilot-GPT4o',
	default_command_agent = 'CodeCopilot',

	chat_user_prefix = '󰭹 :',
	chat_assistant_prefix = { '󰚩 :', '[{{agent}}]' },
	chat_template = table.concat({
		'# topic: ?',
		'- file: {{filename}}',
		'---',
		'',
		'{{user_prefix}}',
	}, '\n'),

	chat_confirm_delete = true,
	chat_conceal_model_params = false,

	chat_shortcut_respond = {
		modes = { 'n', 'i', 'v', 'x' },
		shortcut = '<C-g><C-g>',
		comment = 'GP: Make GP respond',
	},
	chat_shortcut_delete = {
		modes = { 'n' },
		shortcut = '<Space>pD',
		comment = 'GP: Delete chat',
	},
	chat_shortcut_stop = {
		modes = { 'n' },
		shortcut = '<Space>pQ',
		comment = 'GP: Stop responce',
	},
	chat_shortcut_new = {
		modes = { 'n' },
		shortcut = '<Nop>',
	},
	chat_finder_mappings = {
		delete = { modes = { 'n', 'i', 'v', 'x' }, shortcut = '<Nop>' },
	},

	chat_free_cursor = true,

	-- how to display GpChatToggle or GpContext: popup / split / vsplit / tabnew
	toggle_target = '', -- empty for keeping current layout

	-- styling for chatfinder
	style_chat_finder_border = require('utils.common').floatwinborder,

	style_chat_finder_margin_bottom = 8,
	style_chat_finder_margin_left = 1,
	style_chat_finder_margin_right = 2,
	style_chat_finder_margin_top = 2,
	-- how wide should the preview be, number between 0.0 and 1.0
	style_chat_finder_preview_ratio = 0.5,

	-- styling for popup
	style_popup_border = require('utils.common').floatwinborder,
	-- margins are number of characters or lines
	style_popup_margin_bottom = 8,
	style_popup_margin_left = 1,
	style_popup_margin_right = 2,
	style_popup_margin_top = 2,
	style_popup_max_width = 160,

	command_prompt_prefix_template = '󰚩 {{agent}} ~ ',

	image = {
		prompt_save = '󰏫 󰉉 ~ ',
		prompt_prefix_template = '󰏫 {{agent}} ~ ',
	},
}

spec.config = function(_, opts)
	local gp = require('gp')
	gp.setup(opts)

	-- There are no way to close a chat window when setting `toggle_target = ''`
	-- to render a chat window same as normal buffer. To fix that, use buffer-local keymap.
	local set_close_key = function(key)
		if vim.fn.buflisted(vim.fn.bufnr('%')) == 1 then
			return
		end
		vim.keymap.set('n', key, '<Cmd>bnext<CR>', { buffer = true })
	end

	local chat_dir = opts.chat_dir or gp.config.chat_dir
	vim.api.nvim_create_autocmd({ 'BufNew' }, {
		pattern = chat_dir .. '*',
		group = vim.api.nvim_create_augroup('kjuq_gp_bufnew', {}),
		callback = function()
			vim.schedule(function()
				set_close_key('<C-Tab>')
			end)
		end,
	})
end

return spec
