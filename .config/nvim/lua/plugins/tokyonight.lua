return {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 9999,
    config = function()
        vim.cmd.colorscheme("tokyonight")
        vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#808080" })
    end,
}
