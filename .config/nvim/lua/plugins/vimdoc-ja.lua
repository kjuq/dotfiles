return {
    'vim-jp/vimdoc-ja',
    event = { "VimEnter" },
    config = function()
        vim.opt.helplang = "ja,en"
    end,
}


