-- load built-in colorscheme if no colorscheme is loaded by plugin manager
if vim.g.colors_name == nil then
    vim.cmd.colorscheme("default")
    vim.api.nvim_set_hl(0, "WinSeparator", { fg = "DarkGray" })
    vim.api.nvim_set_hl(0, "Cursor", { bg = "LightGray", ctermbg = "LightGray", fg = "Black", ctermfg = "Black" })
    vim.api.nvim_set_hl(0, "Normal", { bg = "NONE", ctermbg = "NONE" })
    vim.api.nvim_set_hl(0, "statusline", { bg = "NONE", ctermbg = "NONE" })
end
