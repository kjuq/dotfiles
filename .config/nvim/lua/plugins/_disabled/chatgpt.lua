local map = require('kjuq.utils.lazy').generate_map('<Space>c', 'ChatGPT: ')

---@type LazySpec
local spec = { 'https://github.com/jackMort/ChatGPT.nvim' }
spec.cmd = { 'ChatGPT', 'ChatGPTActAs', 'ChatGPTEditWithInstructions', 'ChatGPTRun' }

spec.keys = {
	map('c', { 'n' }, '<CMD>ChatGPT<CR>', 'Open ChatGPT'),
	map('e', { 'n', 'x' }, '<CMD>ChatGPTEditWithInstruction<CR>', 'Edit with instruction'),
	map('g', { 'n', 'x' }, '<CMD>ChatGPTRun grammar_correction<CR>', 'Grammar Correction'),
	map('t', { 'n', 'x' }, '<CMD>ChatGPTRun translate<CR>', 'Translate'),
	map('k', { 'n', 'x' }, '<CMD>ChatGPTRun keywords<CR>', 'Keywords'),
	map('d', { 'n', 'x' }, '<CMD>ChatGPTRun docstring<CR>', 'Docstring'),
	map('a', { 'n', 'x' }, '<CMD>ChatGPTRun add_tests<CR>', 'Add Tests'),
	map('o', { 'n', 'x' }, '<CMD>ChatGPTRun optimize_code<CR>', 'Optimize Code'),
	map('s', { 'n', 'x' }, '<CMD>ChatGPTRun summarize<CR>', 'Summarize'),
	map('f', { 'n', 'x' }, '<CMD>ChatGPTRun fix_bugs<CR>', 'Fix Bugs'),
	map('x', { 'n', 'x' }, '<CMD>ChatGPTRun explain_code<CR>', 'Explain Code'),
	map('r', { 'n', 'x' }, '<CMD>ChatGPTRun roxygen_edit<CR>', 'Roxygen Edit'),
	map('l', { 'n', 'x' }, '<CMD>ChatGPTRun code_readability_analysis<CR>', 'Code Readability Analysis'),
}

spec.opts = {
	api_key_cmd = 'pass openai.com/api_key',
	yank_register = '+',
	edit_with_instructions = {
		diff = false,
		keymaps = {
			accept = '<C-y>',
			-- toggle_diff = "<C-d>",
			-- toggle_settings = "<C-o>",
			toggle_help = '<M-h>',
			cycle_windows = '<Tab>',
			use_output_as_input = '<C-i>',
		},
	},
	chat = {
		max_line_length = 120,
		sessions_window = {
			active_sign = ' 󰄵 ',
			inactive_sign = ' 󰄱 ',
		},
		keymaps = {
			close = '<C-c>',
			yank_last = '<C-y>',
			yank_last_code = '<C-k>',
			scroll_up = '<C-u>',
			scroll_down = '<C-d>',
			new_session = '<C-n>',
			cycle_windows = '<Tab>',
			cycle_modes = '<C-f>',
			next_message = '<C-j>',
			prev_message = '<C-k>',
			select_session = '<Space>',
			rename_session = '<M-r>',
			delete_session = 'd',
			draft_message = '<C-r>',
			edit_message = 'e',
			delete_message = 'd',
			toggle_settings = '<C-o>',
			toggle_sessions = '<C-p>',
			toggle_help = '<M-h>',
			toggle_message_role = '<C-r>',
			toggle_system_role_open = '<C-s>',
			stop_generating = '<C-x>',
		},
	},
	popup_input = {
		submit = '<Enter>',
		submit_n = '<C-Enter>',
	},
	openai_params = {
		model = 'gpt-3.5-turbo',
		max_tokens = 3000,
	},
	openai_edit_params = {
		model = 'gpt-3.5-turbo',
	},
	use_openai_functions_for_edits = false,
	actions_paths = {},
	show_quickfixes_cmd = 'Trouble quickfix',
	predefined_chat_gpt_prompts = 'https://raw.githubusercontent.com/f/awesome-chatgpt-prompts/main/prompts.csv',
}

spec.dependencies = {
	'nvim-telescope/telescope.nvim',
}

spec.specs = {
	'MunifTanjim/nui.nvim',
	'nvim-lua/plenary.nvim',
}

return spec
