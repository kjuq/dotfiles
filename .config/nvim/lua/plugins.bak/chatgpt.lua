local map = require("utils.lazy").generate_cmd_map("<leader>c", "ChatGPT: ")

return {
	"jackMort/ChatGPT.nvim",
	cmd = { "ChatGPT", "ChatGPTActAs", "ChatGPTEditWithInstructions", "ChatGPTRun", },
	keys = {
		map("c", { "n" }, "ChatGPT", "Open ChatGPT"),
		map("e", { "n", "v" }, "ChatGPTEditWithInstruction", "Edit with instruction"),
		map("g", { "n", "v" }, "ChatGPTRun grammar_correction", "Grammar Correction"),
		map("t", { "n", "v" }, "ChatGPTRun translate", "Translate"),
		map("k", { "n", "v" }, "ChatGPTRun keywords", "Keywords"),
		map("d", { "n", "v" }, "ChatGPTRun docstring", "Docstring"),
		map("a", { "n", "v" }, "ChatGPTRun add_tests", "Add Tests"),
		map("o", { "n", "v" }, "ChatGPTRun optimize_code", "Optimize Code"),
		map("s", { "n", "v" }, "ChatGPTRun summarize", "Summarize"),
		map("f", { "n", "v" }, "ChatGPTRun fix_bugs", "Fix Bugs"),
		map("x", { "n", "v" }, "ChatGPTRun explain_code", "Explain Code"),
		map("r", { "n", "v" }, "ChatGPTRun roxygen_edit", "Roxygen Edit"),
		map("l", { "n", "v" }, "ChatGPTRun code_readability_analysis", "Code Readability Analysis"),
	},
	_opts = {
		api_key_cmd = "pass openai.com/api_key",
		yank_register = "+",
		chat = {
			keymaps = {
				scroll_down = "<C-d>",
				draft_message = "<M-d>",
			},
		},
		popup_input = {
			submit = "<Enter>",
		},
		openai_params = {
			-- model = "gpt-3.5-turbo",
			max_tokens = 3000, -- https://github.com/jackMort/ChatGPT.nvim/issues/302
		},
	},
	opts = {
		api_key_cmd = "pass openai.com/api_key",
		yank_register = "+",
		edit_with_instructions = {
			diff = false,
			keymaps = {
				accept = "<C-y>",
				-- toggle_diff = "<C-d>",
				-- toggle_settings = "<C-o>",
				toggle_help = "<M-h>",
				cycle_windows = "<Tab>",
				use_output_as_input = "<C-i>",
			},
		},
		chat = {
			max_line_length = 120,
			sessions_window = {
				active_sign = " 󰄵 ",
				inactive_sign = " 󰄱 ",
			},
			keymaps = {
				close = "<C-c>",
				yank_last = "<C-y>",
				yank_last_code = "<C-k>",
				scroll_up = "<C-u>",
				scroll_down = "<C-d>",
				new_session = "<C-n>",
				cycle_windows = "<Tab>",
				cycle_modes = "<C-f>",
				next_message = "<C-j>",
				prev_message = "<C-k>",
				select_session = "<Space>",
				rename_session = "<M-r>",
				delete_session = "d",
				draft_message = "<C-r>",
				edit_message = "e",
				delete_message = "d",
				toggle_settings = "<C-o>",
				toggle_sessions = "<C-p>",
				toggle_help = "<M-h>",
				toggle_message_role = "<C-r>",
				toggle_system_role_open = "<C-s>",
				stop_generating = "<C-x>",
			},
		},
		popup_input = {
			submit = "<Enter>",
			submit_n = "<C-Enter>",
		},
		openai_params = {
			model = "gpt-3.5-turbo",
			max_tokens = 3000,
		},
		openai_edit_params = {
			model = "gpt-3.5-turbo",
		},
		use_openai_functions_for_edits = false,
		actions_paths = {},
		show_quickfixes_cmd = "Trouble quickfix",
		predefined_chat_gpt_prompts = "https://raw.githubusercontent.com/f/awesome-chatgpt-prompts/main/prompts.csv",
	},
	dependencies = {
		"MunifTanjim/nui.nvim",
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim"
	}
}
