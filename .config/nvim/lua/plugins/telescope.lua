return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.3",
    cmd = { "Telescope", desc = "test" },
    keys = {
        -- File pickers
        {
            "<leader>ff",
            mode = { "n" },
            function () require("telescope.builtin").find_files({ hidden = true }) end,
            "Telescope.builtin: [f]ind [f]iles"
        },
        {
            "<leader>gf",
            mode = { "n" },
            function () require('telescope.builtin').git_files() end,
            desc = 'Telescope.builtin: [g]it [f]iles',
        },
        {
            "<leader>fw",
            mode = { "n" },
            function () require('telescope.builtin').grep_string() end,
            desc = 'Telescope.builtin: Current [w]ord',
        },
        {
            "<leader>fg",
            mode = { "n" },
            function () require("telescope.builtin").live_grep() end,
            desc = "Telescope.builtin: Live [g]rep"
        },

        -- Vim pickers
        {
            "<leader>fb",
            mode = { "n" },
            function () require("telescope.builtin").buffers() end,
            desc = "Telescope.builtin: [b]uffers"
        },
        {
            "<leader>fh",
            mode = { "n" },
            function () require("telescope.builtin").oldfiles() end,
            desc = "Telescope.builtin: Old files ([h]istory)"
        },
        {
            "<leader>hc",
            mode = { "n" },
            function () require('telescope.builtin').builtin.command_history() end,
            desc = 'Telescope.builtin: [c]ommand [h]istory',
        },
        {
            "<leader>hs",
            mode = { "n" },
            function () require('telescope.builtin').search_history() end,
            desc = 'Telescope.builtin: [s]earch [h]istory',
        },
        {
            "<leader>fi",
            mode = { "n" },
            function () require("telescope.builtin").help_tags() end,
            desc = "Telescope.builtin: Help tags ([i]ndex)"
        },
        {
            "<leader>fm",
            mode = { "n" },
            function () require("telescope.builtin").man_pages() end,
            desc = "Telescope.builtin: [m]an pages"
        },
        {
            "<leader>lm",
            mode = { "n" },
            function () require('telescope.builtin').marks() end,
            desc = 'Telescope.builtin: [l]ist marks',
        },
        {
            "<leader>lq",
            mode = { "n" },
            function () require('telescope.builtin').quickfix() end,
            desc = 'Telescope.builtin: [l]ist [q]uickfix',
        },
        {
            "<leader>hq",
            mode = { "n" },
            function () require('telescope.builtin').quickfixhistory() end,
            desc = 'Telescope.builtin: [q]uick [h]istory',
        },
        {
            "<leader>ll",
            mode = { "n" },
            function () require('telescope.builtin').loclist() end,
            desc = 'Telescope.builtin: [l]oc[l]ist',
        },
        {
            "<leader>lj",
            mode = { "n" },
            function () require('telescope.builtin').jumplist() end,
            desc = 'Telescope.builtin: [j]ump[l]ist',
        },
        {
            "<leader>fr",
            mode = { "n" },
            function () require("telescope.builtin").registers() end,
            desc = "Telescope.builtin: [r]egisters"
        },
        {
            "<leader>fk",
            mode = { "n" },
            function () require("telescope.builtin").keymaps() end,
            desc = "Telescope.builtin: [k]eymaps"
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
            function () require('telescope.builtin').resume() end,
            desc = 'Telescope.builtin: [r]esume [f]inding',
        },

        -- Neovim LSP pickers
        {
            "<leader>Lr",
            mode = { "n" },
            function () require("telescope.builtin").lsp_references() end,
            desc = "Telescope.builtin.LSP: [r]eferences for word under the cursor"
        },
        {
            "<leader>Lci",
            mode = { "n" },
            function () require("telescope.builtin").lsp_incoming_calls() end,
            desc = "Telescope.builtin.LSP: [i]ncoming calls for word under the cursor"
        },
        {
            "<leader>Lco",
            mode = { "n" },
            function () require("telescope.builtin").lsp_outgoing_calls() end,
            desc = "Telescope.builtin.LSP: [o]utgoing calls for word under the cursor"
        },
        {
            "<leader>fd",
            mode = { "n" },
            function () require("telescope.builtin").diagnostics() end,
            desc = "Telescope.builtin.LSP: [d]iagnostics"
        },
        {
            "<leader>fs",
            mode = { "n" },
            function () require("telescope.builtin").lsp_document_symbols() end,
            desc = "Telescope.builtin.LSP: document [s]ymbols in the current buffer"
        },
        {
            "<leader>fS",
            mode = { "n" },
            function () require("telescope.builtin").lsp_dynamic_workspace_symbols() end,
            desc = "Telescope.builtin.LSP: document [S]ymbols in the current workspace"
        },
        {
            "<leader>Li",
            mode = { "n" },
            function () require("telescope.builtin").lsp_implementations() end,
            desc = "Telescope.builtin.LSP: [i]mplementation of the word under the cursor"
        },
        {
            "<leader>Ld",
            mode = { "n" },
            function () require("telescope.builtin").lsp_definitions() end,
            desc = "Telescope.builtin.LSP: [d]efinition of the word under the cursor"
        },
        {
            "<leader>Lt",
            mode = { "n" },
            function () require("telescope.builtin").lsp_type_definitions() end,
            desc = "Telescope.builtin.LSP: definition of the [t]ype of the word under the cursor"
        },
        -- Git pickers
        -- Treesitter pickers
        {
            "<leader>ft",
            mode = { "n" },
            function () require("telescope.builtin").treesitter() end,
            desc = "Telescope.builtin: Lists Function names, variables, from [t]reesitter"
        },
        -- Lists pickers
        {
            "<leader>lS",
            mode = { "n" },
            function ()
                require("telescope.builtin").symbols {
                    sources = { "emoji", "kaomoji", "gitmoji", "nerd" }
                }
            end,
            desc = "Telescope.builtin: [l]ist [S]ymbols",
        },
        -- Previewers
        -- Extensions
        {
            "<leader>ss",
            mode = { "n" },
            "<Cmd>Telescope xray23 save<CR>",
            desc = "Telescope.extensions: [s]ave [s]essions"
        },
        {
            "<leader>ls",
            mode = { "n" },
            function () require('telescope').extensions.sessions_picker.sessions_picker() end,
            desc = "Telescope.extensions: [l]ist [s]essions"
        },
        {
            "<leader>fc",
            mode = { "n" },
            function () require("telescope").extensions.zoxide.list() end,
            desc = "Telescope.extensions: Zoxide list ([c]d)"
        },
    },
    opts = function ()
        local actions = require("telescope.actions")
        local z_utils = require("telescope._extensions.zoxide.utils")
        local session_dir = vim.fn.stdpath('data') ..'/session/' -- ~/.local/share/nvim/session

        return {
            defaults = {
                mappings = {
                    i = {
                        ["<esc>"] = actions.close,
                        ["<C-c>"] = { "<esc>", type = "command" },
                    },
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
                            before_action = function(selection) print("before C-s") end,
                            action = function(selection)
                                vim.cmd.edit(selection.path)
                            end
                        },
                        -- Opens the selected entry in a new split
                        ["<C-q>"] = { action = z_utils.create_basic_command("split") },
                    },
                },
                sessions_picker = {
                    sessions_dir = session_dir,
                },
                xray23 = {
                    sessionDir = session_dir,
                },
            }
        }
    end,
    dependencies = {
        "nvim-lua/popup.nvim",
        "nvim-lua/plenary.nvim",
        "BurntSushi/ripgrep",
        "nvim-telescope/telescope-symbols.nvim",
        "jvgrootveld/telescope-zoxide",
        "HUAHUAI23/telescope-session.nvim", -- for saving session
        "JoseConseco/telescope_sessions_picker.nvim", -- for listing sessions
    },
}


