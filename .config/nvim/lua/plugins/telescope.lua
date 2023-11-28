local gen_map = require("utils.lazy").generate_map

local mapb = gen_map("<leader>", "Telescope.builtin: ")
local mapbl = gen_map("<leader>", "Telescope.builtin.LSP: ")
local mapex = gen_map("<leader>", "Telescope.extension")

local tb = require("telescope.builtin")
local te = require("telescope").extensions

return {
    "nvim-telescope/telescope.nvim",
    cmd = { "Telescope" },
    keys = {
        -- File pickers

        mapb("ff", "n", function() tb.find_files({ hidden = true }) end, "Find files"),
        mapb("fw", "n", function() tb.grep_string() end, "Find current word"),
        mapb("fg", "n", function() tb.live_grep() end, "Find files with live grep"),

        mapb("gf", "n", function() tb.git_files() end, "Git files"),

        -- Vim pickers

        mapb("fh", "n", function() tb.oldfiles() end, "Find old files"),
        mapb("fb", "n", function() tb.buffers() end, "Find buffers"),
        mapb("fi", "n", function() tb.help_tags() end, "Find help tags"),
        mapb("fm", "n", function() tb.marks() end, "Find marks"),
        mapb("fq", "n", function() tb.quickfix() end, "Find in current quickfix"),
        mapb("fr", "n", function() tb.registers() end, "Find registers"),
        mapb("fk", "n", function() tb.keymaps() end, "Find keymaps"),
        mapb("fz", "n", function() tb.current_buffer_fuzzy_find() end, "Fuzzily search in current buffer"),

        mapb("pc", "n", function() tb.command_history() end, "Find commands history"),
        mapb("pn", "n", function() tb.search_history() end, "Find search history"),
        mapb("pm", "n", function() tb.man_pages() end, "Pick man pages"),
        mapb("pq", "n", function() tb.quickfixhistory() end, "Pick quickfix history"),
        mapb("pl", "n", function() tb.loclist() end, "Pick loclist"),
        mapb("pj", "n", function() tb.jumplist() end, "Pick jumplist"),
        mapb("ph", "n", function() tb.highlights() end, "Pick highlights"),

        mapb("rf", "n", function() tb.resume() end, "Resume finding"),

        -- Neovim LSP pickers

        -- using lspsaga's same function
        -- mapbl("<KEYBIND>", "n", function() tb.lsp_references() end, "[r]eferences for word under the cursor"),
        -- mapbl("<KEYBIND>", "n", function() tb.lsp_incoming_calls() end, "[i]ncoming calls for word under the cursor"),
        -- mapbl("<KEYBIND>", "n", function() tb.lsp_outgoing_calls() end, "[o]utgoing calls for word under the cursor"),

        mapbl("fd", "n", function() tb.diagnostics() end, "Find diagnostics"),
        mapbl("fs", "n", function() tb.lsp_document_symbols() end, "Find document symbols in the current buffer"),
        mapbl("fj", "n", function() tb.lsp_dynamic_workspace_symbols() end, "Find doc Symbols in current workspace"),
        mapbl("ti", "n", function() tb.lsp_implementations() end, "Implementation of the word under the cursor"),
        mapbl("td", "n", function() tb.lsp_definitions() end, "Definition of the word under the cursor"),
        mapbl("tt", "n", function() tb.lsp_type_definitions() end, "Type's definition of the word under the cursor"),

        -- Git pickers

        -- Treesitter pickers

        mapb("ft", "n", function() tb.treesitter() end, "Finds Function names, variables, from treesitter"),

        -- Lists pickers

        mapb("pk", "n", function() tb.symbols { sources = { "emoji", "kaomoji", "gitmoji", "nerd" } } end, "Pick moji"),

        -- Extensions

        mapex("fc", "n", function() te.zoxide.list() end, ".zoxide: Find directory via Zoxide ([c]d)"),
    },
    config = function()
        local actions = require("telescope.actions")
        local actions_layout = require("telescope.actions.layout")

        require("telescope").setup({
            defaults = {
                mappings = {
                    i = {
                        ["<esc>"] = actions.close,
                        ["<C-c>"] = { "<esc>", type = "command" },
                        ["<M-n>"] = require('telescope.actions').cycle_history_next,
                        ["<M-p>"] = require('telescope.actions').cycle_history_prev,
                        ["<M-s>"] = actions_layout.toggle_preview
                    },
                    n = {
                        ["<M-s>"] = actions_layout.toggle_preview
                    },
                },
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
            },
            extensions = {
                zoxide = {
                    prompt_title = "[ Walking on the shoulders of TJ ]",
                    mappings = {
                        default = {
                            after_action = function(selection)
                                print("Update to (" .. selection.z_score .. ") " .. selection.path)
                            end
                        },
                        ["<C-s>"] = {
                            before_action = function(_) print("before C-s") end,
                            action = function(selection)
                                vim.cmd.edit(selection.path)
                            end
                        },
                    },
                },
            },
        })
    end,
    dependencies = {
        "nvim-lua/popup.nvim",
        "nvim-lua/plenary.nvim",
        "BurntSushi/ripgrep",
        "nvim-telescope/telescope-symbols.nvim",
        "jvgrootveld/telescope-zoxide",
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
