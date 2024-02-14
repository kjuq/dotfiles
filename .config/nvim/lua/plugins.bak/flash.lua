local map = require("utils.lazy").generate_map("", "Flash: ")

---@type LazySpec
local spec = { "folke/flash.nvim" }

spec.keys = {
	{ "f", mode = { "n", "x" } },
	{ "F", mode = { "n", "x" } },
	{ "t", mode = { "n", "x" } },
	{ "T", mode = { "n", "x" } },
	{ "df", mode = { "n" }, desc = "Delete to next char" },
	{ "dF", mode = { "n" }, desc = "Delete to previous char" },
	{ "dt", mode = { "n" }, desc = "Delete before next char" },
	{ "dT", mode = { "n" }, desc = "Delete before previous char" },
}

spec.opts = {
	labels = "abcdefghijklmnopqrstuvwxyz",
	search = { multi_window = false },
	label = { uppercase = false },
	highlight = { backdrop = false },
	modes = {
		search = { enabled = false },
		char = {
			multi_line = true,
			highlight = { backdrop = false },
		},
		treesitter_search = {
			search = { multi_window = false },
		},
	},
}

return spec
