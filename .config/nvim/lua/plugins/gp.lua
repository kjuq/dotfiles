local map = require('utils.lazy').generate_map('<leader>c', 'GP: ')

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
	map('c', 'n', '<CMD>GpChatToggle<CR>', 'Open chat'),

	map('q', 'n', '<CMD>GpStop<CR>', 'Stop responses and jobs'),
	map('n', 'n', '<CMD>GpChatNew<CR>', 'Open new chat'),
	map('d', 'n', '<CMD>GpChatDelete<CR>', 'Delete the current chat'),
	map('r', 'n', '<CMD>GpRewrite<CR>', 'Open prompt to rewrite codes'),

	map('f', 'n', '<CMD>GpChatFinder<CR>', 'Search through chats'),
	map('i', 'n', '<CMD>GpImage<CR>', 'Open prompt to generate image'),

	map('y', 'x', '<CMD>GpChatPaste<CR>', 'Paste selected text to a chat'),
	map('j', 'n', '<CMD>GpAppend<CR>', 'Open prompt to append codes'),
	map('k', 'n', '<CMD>GpPrepend<CR>', 'Open prompt to prepend codes'),

	map('X', 'n', '<CMD>GpContext<CR>', 'Configure custom context per repo'),
}

spec.opts = {
	openai_api_key = { 'pass', 'openai.com/api_key' },
	-- chat_dir = os.getenv("HOME") .. "/documents/chatgpt",

	chat_user_prefix = '󰭹 :',
	chat_assistant_prefix = { '󰚩 :', '[{{agent}}]' },

	chat_confirm_delete = true,
	chat_conceal_model_params = false,

	chat_shortcut_respond = { modes = { 'n', 'i', 'v', 'x' }, shortcut = '<C-g><C-g>' },

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

spec.config = function(_, opts)
	local gp = require('gp')
	gp.setup(opts)

	-- There are no way to close a chat window when setting `toggle_target = ''`
	-- to render a chat window same as normal buffer.
	-- To fix that, buffer-local keymap is set.
	local chat_dir = opts.chat_dir or gp.config.chat_dir
	local close_key = 'gh'
	local is_buf_listed = function()
		return vim.fn.buflisted(vim.fn.bufnr('%')) == 1
	end
	local set_close_key = function()
		if is_buf_listed() then
			return
		end
		vim.keymap.set('n', close_key, '<Cmd>bnext<CR>', { buffer = true })
	end

	vim.api.nvim_create_autocmd({ 'BufNew' }, {
		pattern = chat_dir .. '*',
		group = vim.api.nvim_create_augroup('kjuq_gp_bufnew', {}),
		callback = function()
			vim.schedule(set_close_key)
		end,
	})
end

return spec
