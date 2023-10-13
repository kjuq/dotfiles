return {
    'akinsho/toggleterm.nvim',
    version = "*",
    keys = {
        {
            "<C-\\>",
            mode = { "n", "i" },
            function () vim.cmd("ToggleTerm") end,
            desc = "ToggleTerm: open floating window",
        },
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
        open_mapping = "<C-\\>",
        direction = "float",
        float_opts = {
            winblend = 20,
        },
    }
}


