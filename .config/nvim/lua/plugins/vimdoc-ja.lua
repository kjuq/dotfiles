return {
    'vim-jp/vimdoc-ja',
    event = { "CursorHold" },
    config = function()
        vim.opt.helplang = "ja,en"
    end,
}


