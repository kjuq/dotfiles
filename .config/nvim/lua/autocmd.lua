vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = "*.snippets",
    group = vim.api.nvim_create_augroup("user_snippets", {}),
    callback = function()
        vim.opt_local.filetype = "snippets"
    end,
})

vim.api.nvim_create_autocmd({ "CmdwinEnter" }, { -- q:
    group = vim.api.nvim_create_augroup("user_cmdwin_esc", {}),
    callback = function()
        vim.keymap.set("n", "<Esc>", vim.cmd.quit, { buffer = true })
    end,
})

vim.api.nvim_set_hl(0, "UserHighlightOnYank", { bg = "#c43963" }) -- from SagaBeacon of LspSaga
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
    group = vim.api.nvim_create_augroup("user_highlight_on_yank", {}),
    callback = function()
        require("vim.highlight").on_yank({ higroup = "UserHighlightOnYank", timeout = 125 })
    end,
})

require("utils.common").quit_with_esc({ "qf" })
