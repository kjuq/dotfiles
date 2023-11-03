return {
    "andymass/vim-matchup",
    event = { "BufNewFile", "BufReadPost" },
    config = function ()
        require("nvim-treesitter.configs").setup({
            matchup = {
                enable = true,
            },
        })
    end,
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-treesitter/nvim-treesitter-textobjects",
    },
}


