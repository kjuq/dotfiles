return {
    "folke/tokyonight.nvim",
    lazy = false, -- necessary
    priority = 9999,
    config = function()
        require("tokyonight").setup({
            transparent = true,
            styles = {
                sidebars = "transparent", -- "dark", "transparent", "normal"
                floats = "transparent", -- "dark", "transparent", "normal"
            },
        })
        vim.cmd.colorscheme("tokyonight")
        vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#808080" })
    end,
}
