---@module 'lazy'
---@type LazySpec
local spec = { 'https://github.com/robitx/gp.nvim' }

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
	-- Generated at config.hooks
	'GpUnitTests',
	'GpExplain',
	'GpCodeReview',
	'GpTranslator',
	'GpBufferChatNew',
}

local map = require('kjuq.utils.lazy').generate_map('', 'GP: ')
spec.keys = {
	map('<Space>po', 'n', '<CMD>GpChatToggle<CR>', 'Open chat'),
	-- map('<C-w><Space>po', 'n', '<CMD>GpChatToggle vsplit<CR>', 'Open chat'),
	-- map('<Space>pr', 'n', '<CMD>GpRewrite<CR>', 'Open prompt to rewrite codes'),
	-- map('<Space>py', 'x', '<CMD>GpChatPaste<CR>', 'Paste selected text to a chat'),
	-- map('<Space>pj', 'n', '<CMD>GpAppend<CR>', 'Open prompt to append codes'),
	-- map('<Space>pk', 'n', '<CMD>GpPrepend<CR>', 'Open prompt to prepend codes'),
	-- map('<Space>px', 'n', '<CMD>GpContext<CR>', 'Configure custom context per repo'),
	map('<Space>pn', 'n', '<CMD>GpChatNew<CR>', 'Open new chat'),
	-- Generated at config.hooks
	map('<Space>pb', 'n', '<CMD>GpBufferChatNew<CR>', 'Open new chat with entire buffer'),
}

---@type GpConfig
spec.opts = {
	-- chat_dir = os.getenv("HOME") .. "/documents/chatgpt",
	providers = {
		openai = {
			disable = true,
			secret = { 'pass', 'openai.com/api_key' },
		},
		copilot = {
			disable = false,
			-- Secret is automatically fetched with copilot.vim at `$XDG_CONFIG_HOME/github-copilot/hosts.json`
		},
		googleai = {
			secret = { 'pass', 'google.com/gemini_api_key' },
		},
	},

	default_chat_agent = 'ChatCopilot',
	default_command_agent = 'CodeCopilot',

	agents = {
		{
			name = 'Gemini-Plain-JP',
			provider = 'googleai',
			chat = true,
			command = true,
			model = { model = 'gemini-2.5-pro' },
			system_prompt = require('kjuq.utils.ai').plain_prompt('Japanese'),
		},
		{
			name = 'Gemini-Plain-EN',
			provider = 'googleai',
			chat = true,
			command = true,
			model = { model = 'gemini-2.5-pro' },
			system_prompt = require('kjuq.utils.ai').plain_prompt('English'),
		},
		{
			name = 'Chat-Gemini-Code-JP',
			provider = 'googleai',
			chat = true,
			command = false,
			model = { model = 'gemini-2.5-pro' },
			system_prompt = require('kjuq.utils.ai').coding_prompt('Japanese'),
		},
		{
			name = 'Chat-Gemini-Code-EN',
			provider = 'googleai',
			chat = true,
			command = false,
			model = { model = 'gemini-2.5-pro' },
			system_prompt = require('kjuq.utils.ai').coding_prompt('English'),
		},
		{
			name = 'Chat-Gemini-Code-EN',
			provider = 'googleai',
			chat = true,
			command = false,
			model = { model = 'gemini-2.5-pro' },
			system_prompt = require('kjuq.utils.ai').coding_prompt('English'),
		},
		{
			name = 'Copilot-Plain-JP',
			provider = 'copilot',
			chat = true,
			command = true,
			model = { model = 'gemini-2.5-pro' },
			system_prompt = require('kjuq.utils.ai').plain_prompt('Japanese'),
		},
		-- Disable all builtin agents
		{ name = 'ChatGPT4o', disable = true },
		{ name = 'ChatGPT4o-mini', disable = true },
		{ name = 'ChatGPT-o3-mini', disable = true },
		{ name = 'ChatCopilot', disable = true },
		{ name = 'ChatGemini', disable = true },
		{ name = 'ChatPerplexityLlama3.1-8B', disable = true },
		{ name = 'ChatClaude-3-7-Sonnet', disable = true },
		{ name = 'ChatClaude-3-5-Haiku', disable = true },
		{ name = 'ChatOllamaLlama3.1-8B', disable = true },
		{ name = 'ChatLMStudio', disable = true },
		{ name = 'CodeGPT4o', disable = true },
		{ name = 'CodeGPT-o3-mini', disable = true },
		{ name = 'CodeGPT4o-mini', disable = true },
		{ name = 'CodeCopilot', disable = true },
		{ name = 'CodeGemini', disable = true },
		{ name = 'CodePerplexityLlama3.1-8B', disable = true },
		{ name = 'CodeClaude-3-7-Sonnet', disable = true },
		{ name = 'CodeClaude-3-5-Haiku', disable = true },
		{ name = 'CodeOllamaLlama3.1-8B', disable = true },
	},

	hooks = {
		-- example of adding command which writes unit tests for the selected code
		UnitTests = function(gp, params)
			local template = 'I have the following code from {{filename}}:\n\n'
				.. '```{{filetype}}\n{{selection}}\n```\n\n'
				.. 'Please respond by writing table driven unit tests for the code above.'
			local agent = gp.get_command_agent()
			gp.Prompt(params, gp.Target.vnew, agent, template)
		end,
		-- example of adding command which explains the selected code
		Explain = function(gp, params)
			local template = 'I have the following code from {{filename}}:\n\n'
				.. '```{{filetype}}\n{{selection}}\n```\n\n'
				.. 'Please respond by explaining the code above.'
			local agent = gp.get_chat_agent()
			gp.Prompt(params, gp.Target.popup, agent, template)
		end,
		-- example of usig enew as a function specifying type for the new buffer
		CodeReview = function(gp, params)
			local template = 'I have the following code from {{filename}}:\n\n'
				.. '```{{filetype}}\n{{selection}}\n```\n\n'
				.. 'Please analyze for code smells and suggest improvements.'
			local agent = gp.get_chat_agent()
			gp.Prompt(params, gp.Target.enew('markdown'), agent, template)
		end,
		-- example of adding command which opens new chat dedicated for translation
		Translator = function(gp, params)
			local chat_system_prompt = 'You are a Translator, please translate between English and Japanese.'
			gp.cmd.ChatNew(params, chat_system_prompt)
			-- -- you can also create a chat with a specific fixed agent like this:
			-- local agent = gp.get_chat_agent("ChatGPT4o")
			-- gp.cmd.ChatNew(params, chat_system_prompt, agent)
		end,
		-- example of making :%GpChatNew a dedicated command which
		-- opens new chat with the entire current buffer as a context
		BufferChatNew = function(gp, _)
			-- call GpChatNew command in range mode on whole buffer
			vim.api.nvim_command('%' .. gp.config.cmd_prefix .. 'ChatNew')
		end,
	},

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
		shortcut = '<Nop>',
		comment = 'GP: Delete chat',
	},
	chat_shortcut_stop = {
		modes = { 'n' },
		shortcut = '<Space>pQ',
		comment = 'GP: Stop responce',
	},
	chat_shortcut_new = {
		modes = {},
	},
	-- chat_finder_mappings = {
	-- 	delete = { modes = { 'n', 'i', 'v', 'x' }, shortcut = '<Nop>' },
	-- },

	chat_free_cursor = true,

	-- how to display GpChatToggle or GpContext: popup / split / vsplit / tabnew
	toggle_target = '', -- empty for keeping current layout

	-- styling for chatfinder
	style_chat_finder_border = vim.o.winborder,

	style_chat_finder_margin_bottom = 8,
	style_chat_finder_margin_left = 1,
	style_chat_finder_margin_right = 2,
	style_chat_finder_margin_top = 2,
	-- how wide should the preview be, number between 0.0 and 1.0
	style_chat_finder_preview_ratio = 0.5,

	-- styling for popup
	style_popup_border = require('kjuq.utils.helper').floatwinborder,
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
