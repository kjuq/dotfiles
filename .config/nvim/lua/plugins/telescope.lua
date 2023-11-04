local gcc_installed = vim.fn.executable("gcc")
local clang_installed = vim.fn.executable("clang")
local make_installed = vim.fn.executable("make")
local fzf_installable = (gcc_installed or clang_installed) and make_installed

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

        mapb("ff", "n", function() tb.find_files({ hidden = true }) end, "[f]ind [f]iles"),
        mapb("gf", "n", function() tb.git_files() end, '[g]it [f]iles'),
        mapb("fw", "n", function() tb.grep_string() end, '[f]ind current [w]ord'),
        mapb("fg", "n", function() tb.live_grep() end, "[f]ind files with live [g]rep"),

        -- Vim pickers

        mapb("pb", "n", function() tb.buffers() end, "[p]ick [b]uffers"),
        -- mapb("fh", "n", function() tb.oldfiles() end, "[f]ind [h]istory of files"),
        mapb("hc", "n", function() tb.command_history() end, '[h]istory of [c]ommands'),
        mapb("hs", "n", function() tb.search_history() end, '[h]istory of [s]earch'),
        mapb("ph", "n", function() tb.help_tags() end, "[p]ick [h]elp tags"),
        mapb("pm", "n", function() tb.man_pages() end, "[p]ick [m]an pages"),
        mapb("pM", "n", function() tb.marks() end, '[p]ick [M]arks'),
        mapb("pq", "n", function() tb.quickfix() end, '[p]ick [q]uickfix'),
        mapb("hq", "n", function() tb.quickfixhistory() end, '[h]istory of [q]uickfix'),
        mapb("pl", "n", function() tb.loclist() end, '[p]ick [l]oclist'),
        mapb("pj", "n", function() tb.jumplist() end, '[p]ick [j]umplist'),
        mapb("pr", "n", function() tb.registers() end, "[p]ick [r]egisters"),
        mapb("pk", "n", function() tb.keymaps() end, "[p]ick [k]eymaps"),
        mapb("pc", "n", function() tb.highlights() end, "[p]ick highlights ([c]olors)"),
        mapb("fz", "n", function() tb.current_buffer_fuzzy_find() end, "Fu[z]zily search in current buffer"),
        mapb("rf", "n", function() tb.resume() end, '[r]esume [f]inding'),

        -- Neovim LSP pickers

        mapbl("lr", "n", function() tb.lsp_references() end, "[r]eferences for word under the cursor"),
        -- using lspsaga's same function
        -- mapbl("lci", "n", function() tb.lsp_incoming_calls() end, "[i]ncoming calls for word under the cursor"),
        -- mapbl("lco", "n", function() tb.lsp_outgoing_calls() end, "[o]utgoing calls for word under the cursor"),
        mapbl("pd", "n", function() tb.diagnostics() end, "[p]ick [d]iagnostics"),
        mapbl("fs", "n", function() tb.lsp_document_symbols() end, "[f]ind document [s]ymbols in the current buffer"),
        mapbl("fS", "n", function() tb.lsp_dynamic_workspace_symbols() end, "[f]ind doc [S]ymbols in current workspace"),
        mapbl("li", "n", function() tb.lsp_implementations() end, "[i]mplementation of the word under the cursor"),
        mapbl("ld", "n", function() tb.lsp_definitions() end, "[d]efinition of the word under the cursor"),
        mapbl("lt", "n", function() tb.lsp_type_definitions() end, "[t]ype's definition of the word under the cursor"),

        -- Git pickers

        -- Treesitter pickers

        mapb("ft", "n", function() tb.treesitter() end, "[f]inds Function names, variables, from [t]reesitter"),

        -- Lists pickers

        mapb("pS", "n", function() tb.symbols { sources = { "emoji", "kaomoji", "gitmoji", "nerd" } } end,
            "[p]ick [S]ymbols"),

        -- Previewers

        -- Extensions

        mapex("ss", "n", function() vim.cmd("Telescope xray23 save") end, ": [s]ave [s]essions"),
        mapex("ps", "n", function() te.sessions_picker.sessions_picker() end, ".sessions_picker: [p]ick [s]essions"),
        mapex("fc", "n", function() te.zoxide.list() end, ".zoxide: [f]ind directory via Zoxide ([c]d)"),
        mapex("fh", "n", function() vim.cmd("Telescope frecency") end, ".frecency: [f]ind [h]istory of files"),
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
                sessions_picker = {
                    sessions_dir = require("utils.common").session_dir,
                },
                xray23 = {
                    sessionDir = require("utils.common").session_dir,
                },
            }
        })
    end,
    dependencies = {
        "nvim-lua/popup.nvim",
        "nvim-lua/plenary.nvim",
        "BurntSushi/ripgrep",
        "nvim-telescope/telescope-symbols.nvim",
        "jvgrootveld/telescope-zoxide",
        "HUAHUAI23/telescope-session.nvim",           -- for saving session
        "JoseConseco/telescope_sessions_picker.nvim", -- for listing sessions
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
            cond = fzf_installable,
            config = function()
                require('telescope').load_extension('fzf')
            end,
        },
        {
            "nvim-telescope/telescope-frecency.nvim",
            config = function()
                require("telescope").load_extension("frecency")
            end,
        },
    },
}
