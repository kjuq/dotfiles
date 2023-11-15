return {
    "norcalli/nvim-colorizer.lua",
    event = { "CursorMoved", "CursorHold" },
    config = function() -- `opts` not works
        require("colorizer").setup()
        vim.cmd("ColorizerAttachToBuffer")
    end,
}
