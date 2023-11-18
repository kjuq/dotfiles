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

local update_indent_line = function()
    vim.opt_local.listchars:append({ leadmultispace = "╎" .. string.rep("⋅", vim.bo.tabstop - 1) })
end

vim.api.nvim_create_autocmd({ "OptionSet" }, {
    pattern = { "listchars", "tabstop", "filetype" },
    group = vim.api.nvim_create_augroup("update_indent_line", {}),
    callback = update_indent_line,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    group = vim.api.nvim_create_augroup("init_indent_line", {}),
    callback = update_indent_line,
})

require("utils.common").quit_with_esc({ "qf" })
