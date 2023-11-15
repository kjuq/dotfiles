return {
    --- @param ft table<string>
    quit_with_esc = function(ft)
        vim.api.nvim_create_autocmd({ "filetype" }, {
            pattern = ft,
            group = vim.api.nvim_create_augroup("user_autocommands_utils", {}),
            callback = function()
                vim.keymap.set("n", "<esc>", "<cmd>quit<cr>", { buffer = true, silent = true })
            end
        })
    end,

    --- @return boolean
    has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end,

    --- @return boolean
    has_floating_win = function()
        for _, winid in pairs(vim.api.nvim_tabpage_list_wins(0)) do
            if vim.api.nvim_win_get_config(winid).zindex then
                return true
            end
        end
        return false
    end,

    session_dir = vim.fn.stdpath('data') .. '/session/' -- ~/.local/share/nvim/session
}
