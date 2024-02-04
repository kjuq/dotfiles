local map = require("utils.lazy").generate_map("", "Todo: ")

---@type LazySpec
local spec = {
	"folke/todo-comments.nvim",
	event = require("utils.lazy").verylazy,
	keys = {
		map("]t", "n", function() require("todo-comments").jump_next() end, "Next todo comment"),
		map("[t", "n", function() require("todo-comments").jump_prev() end, "Previous todo comment"),
	},
	opts = {
		signs = false,
		highlight = {
			pattern = [[.*<(KEYWORDS)\s*]],
		},
		search = {
			pattern = [[\b(KEYWORDS)\b]],
		},
	},
	dependencies = { "nvim-lua/plenary.nvim" },
}

return spec
