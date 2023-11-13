local augrp = "user_autocommands"
vim.api.nvim_create_augroup(augrp, {})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = "*.snippets",
    group = augrp,
    callback = function()
        vim.opt_local.filetype = "snippets"
    end,
})

vim.api.nvim_create_autocmd({ "CmdwinEnter" }, { -- q:
    pattern = "*",
    group = augrp,
    callback = function()
        vim.keymap.set("n", "<Esc>", vim.cmd.quit, { buffer = true })
    end,
})

vim.api.nvim_create_autocmd({ "TextYankPost" }, {
    pattern = "*",
    callback = function()
        require("vim.highlight").on_yank({ timeout = 125 })
    end,
})

require("utils.common").quit_with_esc({ "qf" })
