return {
    'vim-jp/vimdoc-ja',
    keys = {
        { "h", mode = "c", desc = "open [H]elp" },
    },
    config = function()
        vim.opt.helplang = "ja,en"
    end,
}
