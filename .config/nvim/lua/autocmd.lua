local snippets = vim.api.nvim_create_augroup("user_snippets", {})
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = "*.snippets",
    group = snippets,
    callback = function()
        vim.opt_local.filetype = "snippets"
    end,
})

local cmdwin = vim.api.nvim_create_augroup("user_cmdwin_esc", {})
vim.api.nvim_create_autocmd({ "CmdwinEnter" }, { -- q:
    group = cmdwin,
    callback = function()
        vim.keymap.set("n", "<Esc>", vim.cmd.quit, { buffer = true })
    end,
})

vim.api.nvim_set_hl(0, "UserHighlightOnYank", { bg = "#c43963" }) -- from SagaBeacon of LspSaga
local hlyank = vim.api.nvim_create_augroup("user_highlight_on_yank", {})
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
    group = hlyank,
    callback = function()
        require("vim.highlight").on_yank({ higroup = "UserHighlightOnYank", timeout = 125 })
    end,
})

require("utils.common").quit_with_esc({ "qf" })
