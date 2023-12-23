local gen_map = require("utils.lazy").generate_map

local map = gen_map("<leader>", "Telescope: ")

local tb = require("telescope.builtin")
local te = require("telescope").extensions

return {
    "nvim-telescope/telescope.nvim",
    cmd = { "Telescope" },
    keys = {
        -- File pickers

        map("ff", "n", function() tb.find_files({ hidden = true }) end, "Find files"),
        map("fw", "n", function() tb.grep_string() end, "Find current word"),
        map("fg", "n", function() tb.live_grep() end, "Find files with live grep"),

        map("gf", "n", function() tb.git_files() end, "Git files"),

        -- Vim pickers

        map("fh", "n", function() tb.oldfiles() end, "Find old files"),
        map("fb", "n", function() tb.buffers() end, "Find buffers"),
        map("fi", "n", function() tb.help_tags() end, "Find help tags"),
        map("fm", "n", function() tb.marks() end, "Find marks"),
        map("fq", "n", function() tb.quickfix() end, "Pass results to quickfix"),
        map("fr", "n", function() tb.registers() end, "Find registers"),
        map("fk", "n", function() tb.keymaps() end, "Find keymaps"),
        map("fz", "n", function() tb.current_buffer_fuzzy_find() end, "Fuzzy search"),

        map("pc", "n", function() tb.command_history() end, "Find commands history"),
        map("pn", "n", function() tb.search_history() end, "Find search history"),
        map("pm", "n", function() tb.man_pages() end, "Pick man pages"),
        map("pq", "n", function() tb.quickfixhistory() end, "Pick quickfix history"),
        map("pl", "n", function() tb.loclist() end, "Pick loclist"),
        map("pj", "n", function() tb.jumplist() end, "Pick jumplist"),
        map("ph", "n", function() tb.highlights() end, "Pick highlights"),

        map("rf", "n", function() tb.resume() end, "Resume finding"),

        -- Neovim LSP pickers

        -- using lspsaga's same function
        -- map("<KEYBIND>", "n", function() tb.lsp_references() end, "Lsp references"),
        -- map("<KEYBIND>", "n", function() tb.lsp_incoming_calls() end, "Incoming calls"),
        -- map("<KEYBIND>", "n", function() tb.lsp_outgoing_calls() end, "Outgoing calls"),

        map("fd", "n", function() tb.diagnostics() end, "Find diagnostics"),
        map("fs", "n", function() tb.lsp_document_symbols() end, "Find document symbols"),
        map("fj", "n", function() tb.lsp_dynamic_workspace_symbols() end, "Find doc Symbols"),
        map("ti", "n", function() tb.lsp_implementations() end, "Implementations"),
        map("td", "n", function() tb.lsp_definitions() end, "Definition"),
        map("tt", "n", function() tb.lsp_type_definitions() end, "Type definition"),

        -- Git pickers

        -- Treesitter pickers

        map("ft", "n", function() tb.treesitter() end, "Find via treesitter"),

        -- Lists pickers

        map("pk", "n", function() tb.symbols { sources = { "emoji", "kaomoji", "gitmoji", "nerd" } } end, "Pick moji"),

        -- Extensions

        map("fc", "n", function() te.zoxide.list() end, "Change directory"),
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
