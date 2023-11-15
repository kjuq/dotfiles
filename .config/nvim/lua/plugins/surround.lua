return {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    keys = {
        { "ys", mode = { "n" } },
        { "ds", mode = { "n" } },
        { "cs", mode = { "n" } },
        { "y",  mode = { "x" } },
        { "d",  mode = { "x" } },
        { "c",  mode = { "x" } },
    },
    opts = {},
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-treesitter/nvim-treesitter-textobjects",
    },
}
