return {
    "andymass/vim-matchup",
    event = { "CursorHold", "CursorHoldI" },
    config = function()
        require("nvim-treesitter.configs").setup({
            matchup = {
                enable = true,
            },
        })
        -- for lazy-load, reload filetype
        vim.bo.filetype = vim.bo.filetype
    end,
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-treesitter/nvim-treesitter-textobjects",
    },
}
