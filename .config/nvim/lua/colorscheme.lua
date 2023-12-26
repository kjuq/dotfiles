-- load built-in colorscheme if no colorscheme is loaded by plugin manager
if vim.g.colors_name == nil then
    vim.cmd.colorscheme("habamax")
    vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#808080" })
    vim.api.nvim_set_hl(0, "Normal", { bg = "NONE", ctermbg = "NONE" })
    vim.api.nvim_set_hl(0, "statusline", { bg = "NONE", ctermbg = "NONE" })
end
