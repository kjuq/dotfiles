return {
    "norcalli/nvim-colorizer.lua",
    event = { "CursorHold", "CursorHoldI" },
    config = function() -- `opts` not works
        require("colorizer").setup()
        vim.cmd("ColorizerAttachToBuffer")
    end,
}
