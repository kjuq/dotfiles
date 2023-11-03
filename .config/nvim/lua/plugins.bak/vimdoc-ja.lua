return {
    'vim-jp/vimdoc-ja',
    event = { "BufNewFile", "BufReadPost" },
    config = function()
        vim.opt.helplang = "ja,en"
    end,
}


