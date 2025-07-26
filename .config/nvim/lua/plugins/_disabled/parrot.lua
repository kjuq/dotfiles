---@type LazySpec
local spec = { 'https://github.com/frankroeder/parrot.nvim' }

spec.cmd = {
	'PrtChatNew',
	'PrtChatToggle',
	'PrtChatPaste',
	'PrtInfo',
	'PrtContext',
	'PrtChatFinder',
	'PrtChatDelete',
	'PrtChatRespond',
	'PrtStop',
	'PrtProvider',
	'PrtModel',
	'PrtStatus',
	'PrtRewrite',
	'PrtAppend',
	'PrtPrepend',
	'PrtNew',
	'PrtEnew',
	'PrtVnew',
	'PrtTabnew',
	'PrtRetry',
	'PrtImplement',
	'PrtAsk',
}

spec.opts = {
	-- Providers must be explicitly added to make them available.
	providers = {
		github = {
			api_key = { 'pass', 'github.com/kjuq_repo_token' },
			topic = {
				model = 'claude-3.5-sonnet',
			},
		},
		openai = {
			-- NOTE: Commenting this out to use OpenAI credit unexpectedly. There's no way to set a default provider?
			-- api_key = { 'pass', 'openai.com/api_key' },
		},
	},
	chat_shortcut_respond = { modes = { 'n', 'i', 'v', 'x' }, shortcut = '<C-g><C-g>' },
	chat_shortcut_delete = { modes = { 'n', 'i', 'v', 'x' }, shortcut = '<Nop>' },
	chat_shortcut_stop = { modes = { 'n', 'i', 'v', 'x' }, shortcut = '<Nop>' },
	chat_shortcut_new = { modes = { 'n', 'i', 'v', 'x' }, shortcut = '<Nop>' },
}

spec.specs = {
	'ibhagwan/fzf-lua',
	'nvim-lua/plenary.nvim',
}

return spec
