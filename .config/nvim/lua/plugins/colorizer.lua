return {
    "norcalli/nvim-colorizer.lua",
    event = { "VeryLazy" },
    config = function() -- `opts` not works
        require("colorizer").setup()
        vim.cmd("ColorizerAttachToBuffer")
    end,
}
