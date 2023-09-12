return {
    "nvimdev/lspsaga.nvim",
    -- event = { "LspAttach" },
    config = function()
        require("lspsaga").setup({
            lightbulb = {
                sign = false,
            },
        })
        require("lualine").setup({
            sections = {
                lualine_c = {
                    require("lspsaga.symbol.winbar").get_bar()
                },
            },
        })
        vim.keymap.set("n", "K",  "<cmd>Lspsaga hover_doc<CR>")
        vim.keymap.set('n', '<leader>lf', '<cmd>Lspsaga lsp_finder<CR>')
        vim.keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>")
        vim.keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>")
        vim.keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>")
        vim.keymap.set("n", "<leader>q", "<cmd>Lspsaga show_line_diagnostics<CR>")
        vim.keymap.set("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>")
        vim.keymap.set("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>")

    end,
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons"
    }
}



