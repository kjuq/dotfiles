local map = require("utils.lazy").generate_map("", "LspSaga: ")

---@type LazySpec
local spec = { "nvimdev/lspsaga.nvim" }

spec.keys = {
	map("gD", "n", "<CMD>Lspsaga finder def+ref+imp+tyd<CR>", "Finder"),
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
}

spec.dependencies = {
	"nvim-treesitter/nvim-treesitter",
	"nvim-tree/nvim-web-devicons",
}

return spec
