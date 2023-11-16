local jisyo_l = os.getenv("HOMEBREW_PREFIX") .. "/share/skk-jisyo-l/SKK-JISYO.L"

return {
    "vim-skk/skkeleton",
    event = { "InsertEnter" },
    keys = {
        { "<C-q>", mode = { "i", "c", "t" }, "<Plug>(skkeleton-toggle)", desc = "SKK: Toggle", noremap = false },
    },
    config = function()
        print(jisyo_l)
        vim.fn["skkeleton#config"]({
            eggLikeNewline = true,
            globalJisyo = jisyo_l,
        })
    end,
    dependencies = { "vim-denops/denops.vim" },
}
