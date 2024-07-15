---@type LazySpec
local spec = { "stevearc/dressing.nvim" }

spec.event = { "VeryLazy" }

spec.opts = {
	input = {
		border = require("utils.common").floatwinborder,
		mappings = {
			n = {
				["<Esc>"] = "Close",
				["<CR>"] = "Confirm",
			},
			i = {
				["<C-c>"] = false, -- `false` to disable
				["<Esc>"] = "Close",
				["<CR>"] = "Confirm",
				["<C-p>"] = "HistoryPrev",
				["<C-n>"] = "HistoryNext",
			},
		},
	},
	select = {
		-- backend = { "builtin", "telescope", "fzf_lua", "fzf", "nui" },
		telescope = require("telescope.themes").get_dropdown({
			borderchars = {
				preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
				prompt = { "─", "│", " ", "│", "┌", "┐", "│", "│" },
				results = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
			},
		}),
		nui = {
			border = {
				style = require("utils.common").floatwinborder,
			},
		},
		builtin = {
			border = require("utils.common").floatwinborder,
			mappings = {
				["<Esc>"] = "Close",
				["<C-c>"] = false, -- `false` to disable
				["<CR>"] = "Confirm",
			},
		},
	},
}

return spec
