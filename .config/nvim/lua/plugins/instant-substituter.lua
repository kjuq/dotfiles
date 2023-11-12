return {
    "kjuq/instant-substituter.nvim",
    -- dir = "~/codes/instant-substituter.nvim",
    keys = {
        { "gz",        mode = { "n", "v" } },
        { "<C-l>",     mode = { "n", "v" } },
        { "<leader>o", mode = { "n", "v" } },
    },
    opts = {
        keys = {
            ["gz"] = { [[']], [["]] },
            ["<C-l>"] = { [[-]], [[+]] },
            ["<leader>o"] = { "var", "let" },
        },
        -- debug = true,
    },
}
