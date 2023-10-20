return {
    "nvimdev/lspsaga.nvim",
    event = { "LspAttach" },
    config = function()
        require("lspsaga").setup({
            callhierarchy = {
                keys = {
                    quit = { "q", "<Esc>" },
                },
            },
            code_action = {
                keys = {
                    quit = { "q", "<Esc>" },
                },
            },
            definition = {
                keys = {
                    quit = { "q", "<Esc>" },
                }
            },
            diagnostic = {
                max_height = 0.8,
                keys = {
                    quit = { "q", "<Esc>" },
                }
            },
            finder = {
                max_height = 0.6,
                keys = {
                    toggle_or_open = { "o", "<CR>" },
                    quit = { "q", "<ESC>" },
                }
            },
            lightbulb = {
                enable = false,
            },
            outline = {
                win_width = 45,
                auto_preview = false,
                detail = true,
                keys = {
                    toggle_or_jump = { "o", "<CR>" },
                    quit = { "q", "<Esc>" },
                }
            },
            rename = {
                in_select = true,
                keys = {
                    quit = { "q", "<Esc>" },
                },
            },
        })
        -- hierarchy
        local opts = { desc = "LspSaga: [i]ncoming [c]alls" }
        vim.keymap.set("n", "<leader>ci", "<cmd>Lspsaga incoming_calls<CR>", opts)
        opts = { desc = "LspSaga: [o]utgoing [c]alls" }
        vim.keymap.set("n", "<leader>co", "<cmd>Lspsaga outgoing_calls<CR>", opts)

        -- code action
        opts = { desc = "LspSaga: [c]ode [a]ction" }
        vim.keymap.set({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)

        -- definition
        opts = { desc = "LspSaga: [g]o to [d]efinition" }
        vim.keymap.set("n", "gd", "<cmd>Lspsaga goto_definition<CR>", opts)
        opts = { desc = "LspSaga: [g]o to t[y]pe definition" }
        vim.keymap.set("n", "gy", "<cmd>Lspsaga goto_type_definition<CR>", opts)

        -- diagnostic
        opts = { desc = "LspSaga: Show a detail of the diagnostics on the line focused ([e]rror)" }
        vim.keymap.set("n", "<leader>e", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)
        opts = { desc = "LspSaga: Go to next [e]rror" }
        vim.keymap.set("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
        opts = { desc = "LspSaga: Go to previous [e]rror" }
        vim.keymap.set("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)

        -- finder
        opts = { desc = "LspSaga: Open a floating window showing def, ref, and implementation" }
        vim.keymap.set('n', 'gy', '<cmd>Lspsaga finder def+ref+imp+tyd<CR>', opts)

        -- outline
        opts = { desc = "LspSaga: Show [o]ut line" }
        vim.keymap.set("n", "<leader>lo", "<Cmd>Lspsaga outline<CR>", opts)

        -- rename
        -- opts = { desc = "LspSaga: [r]e[n]ame" }
        -- vim.keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts)

        -- hover
        -- opts = { desc = "LspSaga: Hover doc [K]" }
        -- vim.keymap.set("n", "K",  "<cmd>Lspsaga hover_doc<CR>", opts)

    end,
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons"
    }
}



