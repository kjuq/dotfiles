return {
    --- @param ft table<string>
    quit_with_esc = function(ft)
        vim.api.nvim_create_autocmd({ "filetype" }, {
            pattern = ft,
            callback = function()
                vim.keymap.set("n", "<esc>", "<cmd>quit<cr>", { buffer = true, silent = true })
            end
        })
    end,

    session_dir = vim.fn.stdpath('data') ..'/session/' -- ~/.local/share/nvim/session
}
