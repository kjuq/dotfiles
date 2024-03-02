-- Do `:TSInstall all` manually
-- rust and scala take much time to install

---@type LazySpec
local spec = { "nvim-treesitter/nvim-treesitter" }
spec.event = require("utils.lazy").verylazy
spec.build = function()
	require("nvim-treesitter.install").update({ with_sync = false })()
end

spec.opts = {
	ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "regex", "markdown", "markdown_inline", "bash" },
	sync_install = false,
	auto_install = false, -- don't turn this on, it causes error when `tree-sitter` CLI is not installed

	highlight = {
		enable = true,
		disable = { "perl" },
	},

	indent = { enable = false },

	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<M-v>",
			node_incremental = "<M-v>",
			-- scope_incremental = "",
			node_decremental = "<M-b>",
		},
	},

	textobjects = {
		select = {
			enable = true,
			lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
			keymaps = {
				-- You can use the capture groups defined in textobjects.scm
				["aa"] = "@parameter.outer",
				["ia"] = "@parameter.inner",
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["aC"] = "@class.outer",
				["iC"] = "@class.inner",
				["ai"] = "@conditional.outer", -- [i]f
				["ii"] = "@conditional.inner",
				["al"] = "@loop.outer",
				["il"] = "@loop.inner",
				["a/"] = "@comment.outer",
				["i/"] = "@comment.inner",
				["ag"] = "@call.outer", -- ar[g]uments
				["ig"] = "@call.inner",
				["ah"] = "@block.outer", -- [h]ere
				["ih"] = "@block.inner",
			},
		},
		move = {
			enable = true,
			set_jumps = true, -- whether to set jumps in the jumplist
			goto_next_start = {
				["]f"] = "@function.outer",
			},
			goto_next_end = {
				["]F"] = "@function.outer",
			},
			goto_previous_start = {
				["[f"] = "@function.outer",
			},
			goto_previous_end = {
				["[F"] = "@function.outer",
			},
		},
		swap = {
			enable = true,
			swap_next = {
				["<M-t>"] = "@parameter.inner",
			},
			swap_previous = {
				["g<M-t>"] = "@parameter.inner",
			},
		},
	},
}

spec.config = function()
	require("nvim-treesitter.configs").setup(spec.opts)
end

---@diagnostic disable-next-line: inject-field
spec._user_load_library = true

spec.dependencies = {
	"nvim-treesitter/nvim-treesitter-textobjects",
}

return spec
