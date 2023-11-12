vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = "*.snippets",
    callback = function()
        vim.opt_local.filetype = "snippets"
    end,
})

vim.api.nvim_create_autocmd({ "CmdwinEnter" }, {
    pattern = "*",
    callback = function()
        vim.keymap.set("n", "<Esc>", "<Cmd>quit<CR>", { buffer = true })
    end,
})

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
    pattern = "*",
    callback = function()
        require("vim.highlight").on_yank({ timeout = 125 })
    end,
})

require("utils.common").quit_with_esc({ "qf" })
