local map = require("utils.lazy").generate_map("", "LspSaga: ")

---@type LazySpec
local spec = { "nvimdev/lspsaga.nvim" }

spec.keys = {
	map("<M-i>", "n", "<CMD>Lspsaga incoming_calls<CR>", "Incoming calls"),
	map("<M-o>", "n", "<CMD>Lspsaga outgoing_calls<CR>", "Outgoing calls"),
	map("gD", "n", "<CMD>Lspsaga finder def+ref+imp+tyd<CR>", "Finder"),
	-- map("", { "n", "v" }, "Lspsaga code_action", "Code action"),
	-- map("", "n", "Lspsaga goto_definition", "Definition"),
	-- map("", "n", "Lspsaga hover_doc", "Hover doc"),
}

spec.opts = {
	breadcrumbs = { enabled = false },
	callhierarchy = { keys = { quit = { "q", "<Esc>" } } },
	code_action = { keys = { quit = { "q", "<Esc>" } } },
	definition = { keys = { quit = { "q", "<Esc>" } } },
	diagnostic = { max_height = 0.8, keys = { quit = { "q", "<Esc>" } } },
	finder = { max_height = 0.6, keys = { toggle_or_open = { "o", "<CR>" }, quit = { "q", "<ESC>" } } },
	lightbulb = { enable = false },
	rename = { in_select = true, keys = { quit = { "q", "<Esc>" } } },
	outline = {
		win_width = 45,
		auto_preview = false,
		detail = true,
		keys = {
			toggle_or_jump = { "o", "<CR>" },
			quit = { "q", "<Esc>" },
		},
	},
	scroll_preview = {
		scroll_down = "<C-d>",
		scroll_up = "<C-u>",
	},
}

spec.dependencies = {
	"nvim-treesitter/nvim-treesitter",
	"nvim-tree/nvim-web-devicons",
}

return spec
