return {
    'akinsho/toggleterm.nvim',
    version = "*",
    keys = {
        { "<C-\\>", mode = { "n", "i" }, function () vim.cmd("ToggleTerm") end },

    },
    cmd = {
        "ToggleTerm",
        "ToggleTermSetName",
        "ToggleTermToggleAll",
        "ToggleTermSendCurrentLine",
        "ToggleTermSendVisualLines",
        "ToggleTermSendVisualSelection",
    },
    opts = {
        open_mapping = [[<c-\>]],
        direction = "float",
    }
}


