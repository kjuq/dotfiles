return {
    "karb94/neoscroll.nvim",
    keys = {
        { "<C-u>", mode = { "n", "x" } },
        { "<C-d>", mode = { "n", "x" } },
        { "<C-b>", mode = { "n", "x" } },
        { "<C-f>", mode = { "n", "x" } },
        { "zt",    mode = { "n", "x" } },
        { "zz",    mode = { "n", "x" } },
        { "zb",    mode = { "n", "x" } },
    },
    config = function()
        require("neoscroll").setup({
            mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "zt", "zz", "zb" },
            hide_cursor = false,
        })

        local t    = {}
        t["<C-u>"] = { "scroll", { "-vim.wo.scroll", "true", "125", nil } }
        t["<C-d>"] = { "scroll", { "vim.wo.scroll", "true", "125", nil } }
        t["<C-b>"] = { "scroll", { "-vim.api.nvim_win_get_height(0)", "true", "175", nil } }
        t["<C-f>"] = { "scroll", { "vim.api.nvim_win_get_height(0)", "true", "175", nil } }
        t["zt"]    = { "zt", { "150" } }
        t["zz"]    = { "zz", { "150" } }
        t["zb"]    = { "zb", { "150" } }

        require("neoscroll.config").set_mappings(t)
    end
}
