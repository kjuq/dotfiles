return {
    "nvimdev/lspsaga.nvim",
    event = { "LspAttach" },
    config = function()
        require("lspsaga").setup({
            callhierarchy = { keys = { quit = { "q", "<Esc>" } } },
            code_action = { keys = { quit = { "q", "<Esc>" } } },
            definition = { keys = { quit = { "q", "<Esc>" } } },
            diagnostic = { max_height = 0.8, keys = { quit = { "q", "<Esc>" } } },
            finder = { max_height = 0.6, keys = { toggle_or_open = { "o", "<CR>" }, quit = { "q", "<ESC>" } } },
            lightbulb = { enable = false, },
            rename = { in_select = true, keys = { quit = { "q", "<Esc>" } } },
            outline = {
                win_width = 45,
                auto_preview = false,
                detail = true,
                keys = {
                    toggle_or_jump = { "o", "<CR>" },
                    quit = { "q", "<Esc>" },
                }
            },
        })
        -- hierarchy
        local opts = { desc = "LspSaga: [i]ncoming [c]alls" }
        vim.keymap.set("n", "<leader>lci", "<cmd>Lspsaga incoming_calls<CR>", opts)
        opts = { desc = "LspSaga: [o]utgoing [c]alls" }
        vim.keymap.set("n", "<leader>lco", "<cmd>Lspsaga outgoing_calls<CR>", opts)

        -- code action
        opts = { desc = "LspSaga: [c]ode [a]ction" }
        vim.keymap.set({ "n", "v" }, "<leader>la", "<cmd>Lspsaga code_action<CR>", opts)

        -- finder
        opts = { desc = "LspSaga: Open a floating window showing def, ref, and implementation" }
        vim.keymap.set('n', 'gy', '<cmd>Lspsaga finder def+ref+imp+tyd<CR>', opts)

        -- outline
        opts = { desc = "LspSaga: Show out line" }
        vim.keymap.set("n", "<leader>lz", "<Cmd>Lspsaga outline<CR>", opts)
    end,
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons"
    }
}
