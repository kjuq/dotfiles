local gcc_installed = vim.fn.executable("gcc")
local clang_installed = vim.fn.executable("clang")
local make_installed = vim.fn.executable("make")
local fzf_installable = (gcc_installed or clang_installed) and make_installed

return {
    "nvim-telescope/telescope.nvim",
    cmd = { "Telescope" },
    keys = {
        -- File pickers {{{
        {
            "<leader>ff",
            mode = { "n" },
            function() require("telescope.builtin").find_files({ hidden = true }) end,
            "Telescope.builtin: [f]ind [f]iles"
        },
        {
            "<leader>gf",
            mode = { "n" },
            function() require('telescope.builtin').git_files() end,
            desc = 'Telescope.builtin: [g]it [f]iles',
        },
        {
            "<leader>fw",
            mode = { "n" },
            function() require('telescope.builtin').grep_string() end,
            desc = 'Telescope.builtin: [f]ind current [w]ord',
        },
        {
            "<leader>fg",
            mode = { "n" },
            function() require("telescope.builtin").live_grep() end,
            desc = "Telescope.builtin: [f]ind files with live [g]rep"
        },
        -- }}}

        -- Vim pickers {{{
        {
            "<leader>pb",
            mode = { "n" },
            function() require("telescope.builtin").buffers() end,
            desc = "Telescope.builtin: [p]ick [b]uffers"
        },
        {
            "<leader>fh",
            mode = { "n" },
            function() require("telescope.builtin").oldfiles() end,
            desc = "Telescope.builtin: [f]ind [h]istory of [f]iles"
        },
        {
            "<leader>hc",
            mode = { "n" },
            function() require('telescope.builtin').command_history() end,
            desc = 'Telescope.builtin: [h]istory of [c]ommands',
        },
        {
            "<leader>hs",
            mode = { "n" },
            function() require('telescope.builtin').search_history() end,
            desc = 'Telescope.builtin: [h]istory of [s]earch',
        },
        {
            "<leader>ph",
            mode = { "n" },
            function() require("telescope.builtin").help_tags() end,
            desc = "Telescope.builtin: [p]ick [h]elp tags"
        },
        {
            "<leader>pm",
            mode = { "n" },
            function() require("telescope.builtin").man_pages() end,
            desc = "Telescope.builtin: [p]ick [m]an pages"
        },
        {
            "<leader>pM",
            mode = { "n" },
            function() require('telescope.builtin').marks() end,
            desc = 'Telescope.builtin: [p]ick [M]arks',
        },
        {
            "<leader>pq",
            mode = { "n" },
            function() require('telescope.builtin').quickfix() end,
            desc = 'Telescope.builtin: [p]ick [q]uickfix',
        },
        {
            "<leader>hq",
            mode = { "n" },
            function() require('telescope.builtin').quickfixhistory() end,
            desc = 'Telescope.builtin: [h]istory of [q]uickfix',
        },
        {
            "<leader>pl",
            mode = { "n" },
            function() require('telescope.builtin').loclist() end,
            desc = 'Telescope.builtin: [p]ick [l]oclist',
        },
        {
            "<leader>pj",
            mode = { "n" },
            function() require('telescope.builtin').jumplist() end,
            desc = 'Telescope.builtin: [p]ick [j]umplist',
        },
        {
            "<leader>pr",
            mode = { "n" },
            function() require("telescope.builtin").registers() end,
            desc = "Telescope.builtin: [p]ick [r]egisters"
        },
        {
            "<leader>pk",
            mode = { "n" },
            function() require("telescope.builtin").keymaps() end,
            desc = "Telescope.builtin: [p]ick [k]eymaps"
        },
        {
            "<leader>pc",
            mode = { "n" },
            function() require("telescope.builtin").highlights() end,
            desc = "Telescope.builtin: [p]ick highlights ([c]olors)"
        },
        {
            "<leader>fz",
            mode = { "n" },
            function()
                require('telescope.builtin').current_buffer_fuzzy_find(
                    require('telescope.themes').get_dropdown {
                        winblend = 10,
                        previewer = false,
                    }
                )
            end,
            desc = "Telescope.builtin: Fu[z]zily search in current buffer",
        },
        {
            "<leader>rf",
            mode = { "n" },
            function() require('telescope.builtin').resume() end,
            desc = 'Telescope.builtin: [r]esume [f]inding',
        },
        -- }}}

        -- Neovim LSP pickers {{{
        {
            "<leader>lr",
            mode = { "n" },
            function() require("telescope.builtin").lsp_references() end,
            desc = "Telescope.builtin.[l]SP: [r]eferences for word under the cursor"
        },
        {
            "<leader>lci",
            mode = { "n" },
            function() require("telescope.builtin").lsp_incoming_calls() end,
            desc = "Telescope.builtin.[l]SP: [i]ncoming calls for word under the cursor"
        },
        {
            "<leader>lco",
            mode = { "n" },
            function() require("telescope.builtin").lsp_outgoing_calls() end,
            desc = "Telescope.builtin.[l]SP: [o]utgoing calls for word under the cursor"
        },
        {
            "<leader>pd",
            mode = { "n" },
            function() require("telescope.builtin").diagnostics() end,
            desc = "Telescope.builtin.LSP: [p]ick [d]iagnostics"
        },
        {
            "<leader>fs",
            mode = { "n" },
            function() require("telescope.builtin").lsp_document_symbols() end,
            desc = "Telescope.builtin.LSP: [f]ind document [s]ymbols in the current buffer"
        },
        {
            "<leader>fS",
            mode = { "n" },
            function() require("telescope.builtin").lsp_dynamic_workspace_symbols() end,
            desc = "Telescope.builtin.LSP: [f]ind document [S]ymbols in the current workspace"
        },
        {
            "<leader>li",
            mode = { "n" },
            function() require("telescope.builtin").lsp_implementations() end,
            desc = "Telescope.builtin.[l]SP: [i]mplementation of the word under the cursor"
        },
        {
            "<leader>ld",
            mode = { "n" },
            function() require("telescope.builtin").lsp_definitions() end,
            desc = "Telescope.builtin.[l]SP: [d]efinition of the word under the cursor"
        },
        {
            "<leader>lt",
            mode = { "n" },
            function() require("telescope.builtin").lsp_type_definitions() end,
            desc = "Telescope.builtin.[l]SP: definition of the [t]ype of the word under the cursor"
        },
        -- }}}

        -- Git pickers

        -- Treesitter pickers {{{
        {
            "<leader>ft",
            mode = { "n" },
            function() require("telescope.builtin").treesitter() end,
            desc = "Telescope.builtin: [f]inds Function names, variables, from [t]reesitter"
        },
        -- }}}

        -- Lists pickers {{{
        {
            "<leader>pS",
            mode = { "n" },
            function()
                require("telescope.builtin").symbols {
                    sources = { "emoji", "kaomoji", "gitmoji", "nerd" }
                }
            end,
            desc = "Telescope.builtin: [p]ick [S]ymbols",
        },
        -- }}}

        -- Previewers

        -- Extensions {{{
        {
            "<leader>ss",
            mode = { "n" },
            "<Cmd>Telescope xray23 save<CR>",
            desc = "Telescope.extensions: [s]ave [s]essions"
        },
        {
            "<leader>ps",
            mode = { "n" },
            function() require('telescope').extensions.sessions_picker.sessions_picker() end,
            desc = "Telescope.extensions: [p]ick [s]essions"
        },
        {
            "<leader>fc",
            mode = { "n" },
            function() require("telescope").extensions.zoxide.list() end,
            desc = "Telescope.extensions: [f]ind directory via Zoxide ([c]d)"
        },
        -- }}}
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
        if fzf_installable then
            require('telescope').load_extension('fzf')
        end
    end,
    dependencies = {
        "nvim-lua/popup.nvim",
        "nvim-lua/plenary.nvim",
        "BurntSushi/ripgrep",
        "nvim-telescope/telescope-symbols.nvim",
        "jvgrootveld/telescope-zoxide",
        "HUAHUAI23/telescope-session.nvim",           -- for saving session
        "JoseConseco/telescope_sessions_picker.nvim", -- for listing sessions
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make", cond = fzf_installable }
    },
}
