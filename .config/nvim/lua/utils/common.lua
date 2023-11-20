return {
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

    -- https://github.com/neovim/neovim/blob/b535575acdb037c35a9b688bc2d8adc2f3dece8d/src/nvim/keymap.h#L225
    -- https://www.reddit.com/r/neovim/comments/kup1g0/comment/givujwd
    ---@param cmd string
    feed_plug = function(cmd)
        vim.fn.feedkeys(string.format("%c%c%c" .. cmd, 0x80, 253, 83))
    end,

    -- https://stackoverflow.com/questions/72165140/vim-bufnewfile-autocmd-does-not-work-when-inside-filetype-plugin
    ---@return boolean
    is_empty_buffer = function()
        return vim.fn.filereadable(vim.fn.bufname()) == 0 and vim.fn.line("$") == 1 and vim.fn.getline(1) == ""
    end,

    session_dir = vim.fn.stdpath('data') .. '/session/' -- ~/.local/share/nvim/session
}
