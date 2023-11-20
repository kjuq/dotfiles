return {
    "ellisonleao/gruvbox.nvim",
    config = function()
        require("gruvbox").setup({
            transparent_mode = true,
            dim_inactive = false,
        })
        vim.cmd.colorscheme("gruvbox")
        vim.api.nvim_set_hl(0, "statusline", { bg = "NONE" })
    end,
}
