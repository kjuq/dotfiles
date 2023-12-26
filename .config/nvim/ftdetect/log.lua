vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "*.log", "*_log", ".LOG", "_LOG" },
    group = vim.api.nvim_create_augroup("user_ft_log", {}),
    callback = function()
        vim.opt_local.filetype = "log"
    end,
})
