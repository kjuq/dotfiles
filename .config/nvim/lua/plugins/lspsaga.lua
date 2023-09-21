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
                sign = false,
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
        vim.keymap.set("n", "<leader>hi", "<cmd>Lspsaga incoming_calls<CR>")
        vim.keymap.set("n", "<leader>ho", "<cmd>Lspsaga outgoing_calls<CR>")

        -- code action
        vim.keymap.set({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>")

        -- definition
        vim.keymap.set("n", "<leader>gd", "<cmd>Lspsaga peek_definition<CR>")
        vim.keymap.set("n", "<leader><Space>td", "<cmd>Lspsaga peek_type_definition<CR>")
        vim.keymap.set("n", "gd", "<cmd>Lspsaga goto_definition<CR>")
        vim.keymap.set("n", "<leader>td", "<cmd>Lspsaga goto_type_definition<CR>")

        -- diagnostic
        vim.keymap.set("n", "<leader>e", "<cmd>Lspsaga show_line_diagnostics<CR>")
        vim.keymap.set("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>")
        vim.keymap.set("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>")

        -- finder
        vim.keymap.set('n', 'gD', '<cmd>Lspsaga finder def+ref+imp<CR>')

        -- hover
        vim.keymap.set("n", "K",  "<cmd>Lspsaga hover_doc<CR>")

        -- outline
        vim.keymap.set("n", "<leader>ol", "<Cmd>Lspsaga outline<CR>")

        -- rename
        vim.keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>")

    end,
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons"
    }
}



