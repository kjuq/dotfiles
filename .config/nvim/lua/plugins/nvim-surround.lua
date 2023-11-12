return {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    keys = {
        { "ys", mode = { "n", "x" } },
        { "ds", mode = { "n", "x" } },
        { "cs", mode = { "n", "x" } },
    },
    opts = {},
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-treesitter/nvim-treesitter-textobjects",
    },
}
