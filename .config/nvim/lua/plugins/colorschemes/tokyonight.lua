return {
    "folke/tokyonight.nvim",
    config = function()
        require("tokyonight").setup({
            transparent = true,
            dim_inactive = false,
            styles = {
                sidebars = "transparent", -- "dark", "transparent", "normal"
                floats = "transparent",   -- "dark", "transparent", "normal"
            },
        })
        vim.cmd.colorscheme("tokyonight")
        vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#808080" })
        vim.api.nvim_set_hl(0, "statusline", { bg = "NONE", ctermbg = "NONE" })
    end,
}
