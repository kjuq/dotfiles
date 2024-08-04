local map = require('utils.lazy').generate_map('<leader>c', 'GP: ')

local nv = { 'n', 'v' }

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
	'GpContext',
	'GpNextAgent',
	'GpAgent',
	'GpImage',
	'GpImageAgent',
}

spec.keys = {
	map('n', nv, '<CMD>GpChatNew<CR>', 'Open new chat'),
	map('p', nv, '<CMD>GpChatPaste<CR>', 'Paste selected text to a chat'),
	map('c', nv, '<CMD>GpChatToggle<CR>', 'Open chat'),
	map('f', nv, '<CMD>GpChatFinder<CR>', 'Search through chats'),
	map('R', nv, '<CMD>GpChatRespond<CR>', 'Request a new GPT response'),
	map('d', nv, '<CMD>GpChatDelete<CR>', 'Delete the current chat'),
	map('r', nv, '<CMD>GpRewrite<CR>', 'Open prompt to rewrite codes'),
	map('j', nv, '<CMD>GpAppend<CR>', 'Open prompt to append codes'),
	map('k', nv, '<CMD>GpPrepend<CR>', 'Open prompt to prepend codes'),
	map('.', nv, '<CMD>GpContext<CR>', 'Configure custom context per repo'),
	map('i', nv, '<CMD>GpImage<CR>', 'Open prompt to generate image'),
	map('q', nv, '<CMD>GpStop<CR>', 'Stop responses and jobs'),
}

spec.opts = {
	openai_api_key = { 'pass', 'openai.com/api_key' },
	-- chat_dir = os.getenv("HOME") .. "/documents/chatgpt",

	chat_user_prefix = '󰭹 :',
	chat_assistant_prefix = { '󰚩 :', '[{{agent}}]' },

	chat_topic_gen_model = 'gpt-3.5-turbo-16k',

	chat_confirm_delete = true,
	chat_conceal_model_params = false,

	chat_shortcut_respond = { modes = { 'n', 'i', 'v', 'x' }, shortcut = '<C-g><C-g>' },
	chat_shortcut_delete = { modes = { 'n', 'i', 'v', 'x' }, shortcut = '<C-g>h' },
	chat_shortcut_stop = { modes = { 'n', 'i', 'v', 'x' }, shortcut = '<C-g>c' },
	chat_shortcut_new = { modes = { 'n', 'i', 'v', 'x' }, shortcut = '<C-g>n' },

	-- how to display GpChatToggle or GpContext: popup / split / vsplit / tabnew
	toggle_target = '', -- empty for keeping current layout

	-- styling for chatfinder
	style_chat_finder_border = 'single',

	style_chat_finder_margin_bottom = 8,
	style_chat_finder_margin_left = 1,
	style_chat_finder_margin_right = 2,
	style_chat_finder_margin_top = 2,
	-- how wide should the preview be, number between 0.0 and 1.0
	style_chat_finder_preview_ratio = 0.5,

	-- styling for popup
	style_popup_border = 'single',
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

return spec
