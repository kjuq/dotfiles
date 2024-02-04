local gen_map = require("utils.lazy").generate_map

local map = gen_map("<leader>", "Telescope: ")

local tb = "telescope.builtin"

---@type LazySpec
local spec = {
	"nvim-telescope/telescope.nvim",
	cmd = { "Telescope" },
	keys = {
		-- File pickers

		map("ff", "n", function() require(tb).find_files({ hidden = true }) end, "Files on current dir"),
		map("fw", "n", function() require(tb).grep_string() end, "Word on the cursor"),
		map("fg", "n", function() require(tb).live_grep() end, "Live grep"),

		map("gf", "n", function() require(tb).git_files() end, "Git files"),

		-- Vim pickers

		map("fh", "n", function() require(tb).oldfiles() end, "Old files"),
		map("fb", "n", function() require(tb).buffers() end, "Buffers"),
		map("fi", "n", function() require(tb).help_tags() end, "Help tags"),
		map("fm", "n", function() require(tb).marks() end, "Marks"),
		map("fQ", "n", function() require(tb).quickfix() end, "Quickfix"),
		map("fr", "n", function() require(tb).registers() end, "Registers"),
		map("fk", "n", function() require(tb).keymaps() end, "Keymaps"),
		map("fn", "n", function() require(tb).current_buffer_fuzzy_find() end, "Fuzzy search"),

		map("fc", "n", function() require(tb).command_history() end, "Commands history"),
		map("fN", "n", function() require(tb).search_history() end, "Search history"),
		map("fM", "n", function() require(tb).man_pages() end, "Man pages"),
		map("fq", "n", function() require(tb).quickfixhistory() end, "Quickfix history"),
		map("fL", "n", function() require(tb).loclist() end, "Loclist"),
		map("fj", "n", function() require(tb).jumplist() end, "Jumplist"),
		map("fH", "n", function() require(tb).highlights() end, "Highlights"),

		map("rf", "n", function() require(tb).resume() end, "Resume finding"),

		-- Neovim LSP pickers

		-- using lspsaga's same function
		-- map("<KEYBIND>", "n", function() require(tb).lsp_references() end, "Lsp references"),
		-- map("<KEYBIND>", "n", function() require(tb).lsp_incoming_calls() end, "Incoming calls"),
		-- map("<KEYBIND>", "n", function() require(tb).lsp_outgoing_calls() end, "Outgoing calls"),

		map("fd", "n", function() require(tb).diagnostics() end, "Diagnostics"),
		map("fS", "n", function() require(tb).lsp_document_symbols() end, "Document symbols"),
		map("fW", "n", function() require(tb).lsp_dynamic_workspace_symbols() end, "Doc Symbols"),
		map("fI", "n", function() require(tb).lsp_implementations() end, "Implementations"),
		map("fD", "n", function() require(tb).lsp_definitions() end, "Definitions"),
		map("fT", "n", function() require(tb).lsp_type_definitions() end, "Type definitions"),

		-- Git pickers

		-- Treesitter pickers

		map("ft", "n", function() require(tb).treesitter() end, "Find via treesitter"),

		-- Lists pickers

		map("fs", "n", function()
			require(tb).symbols({ sources = { "emoji", "kaomoji", "gitmoji", "nerd" } })
		end, "Symbols"),

	},
	config = function()
		local actions = require("telescope.actions")
		local actions_layout = require("telescope.actions.layout")

		require("telescope").setup({
			defaults = {
				default_mappings = {
					i = {
						["<C-n>"] = actions.move_selection_next,
						["<C-p>"] = actions.move_selection_previous,

						["<C-c>"] = actions.close,

						["<CR>"] = actions.select_default,

						["<C-s>"] = actions.select_vertical,

						[require("utils.lazy").floatscrollup] = actions.preview_scrolling_up,
						[require("utils.lazy").floatscrolldown] = actions.preview_scrolling_down,
						["<M-b>"] = actions.preview_scrolling_left,
						["<M-f>"] = actions.preview_scrolling_right,

						["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
						["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,

						["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
						["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

						["<C-l>"] = actions.complete_tag,
						["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
						["<C-w>"] = { "<c-s-w>", type = "command" },

						-- disable c-j because we dont want to allow new lines #2123
						["<C-j>"] = actions.nop,
					},

					n = {
						["<esc>"] = actions.close,

						["<CR>"] = actions.select_default,

						["<C-s>"] = actions.select_vertical,

						["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
						["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
						["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
						["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

						["j"] = actions.move_selection_next,
						["k"] = actions.move_selection_previous,

						["<C-n>"] = actions.move_selection_next,
						["<C-p>"] = actions.move_selection_previous,

						["gg"] = actions.move_to_top,
						["G"] = actions.move_to_bottom,

						[require("utils.lazy").floatscrollup] = actions.preview_scrolling_up,
						[require("utils.lazy").floatscrolldown] = actions.preview_scrolling_down,
						["<M-f>"] = actions.preview_scrolling_left,
						["<M-b>"] = actions.preview_scrolling_right,

						["?"] = actions.which_key,
					}
				},
				mappings = {
					i = {
						["<esc>"] = actions.close,
						["<C-c>"] = { "<esc>", type = "command" },

						["<M-n>"] = actions.cycle_history_next,
						["<M-p>"] = actions.cycle_history_prev,
					},
					n = {
						["<esc>"] = actions.close,
						["K"] = actions_layout.toggle_preview,
						["<M-n>"] = actions.cycle_history_next,
						["<M-p>"] = actions.cycle_history_prev,
					},
				},
				layout_strategy = "vertical", -- center, vertical, horizontal, flex
				scroll_strategy = "limit",
				path_display = { truncate = 3 },
				preview = {
					hide_on_startup = false,
				},
				vimgrep_arguments = {
					"rg",
					"--hidden",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case"
				},
				file_ignore_patterns = {
					".git/",
					"node_modules/",
				},
				borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" }, -- presets such as "single" and "rounded" are not supported
			},
		})
	end,
	dependencies = {
		"nvim-lua/popup.nvim",
		"nvim-lua/plenary.nvim",
		"BurntSushi/ripgrep",
		"nvim-telescope/telescope-symbols.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			cond = (vim.fn.executable("gcc") == 1 or vim.fn.executable("clang") == 1) and vim.fn.executable("make") == 1,
			config = function()
				require("telescope").load_extension("fzf")
			end,
		},
	},
}

return spec
