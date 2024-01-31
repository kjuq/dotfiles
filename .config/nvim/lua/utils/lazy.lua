local M = {}

--- @param key_prefix string
--- @param desc_prefix string
M.generate_map = function(key_prefix, desc_prefix)
    --- @param suffix string
    --- @param mode string|table
    --- @param func function
    --- @param comment string
    local map = function(suffix, mode, func, comment)
        local key = key_prefix .. suffix
        local desc = desc_prefix .. comment

        return { key, mode = mode, func, desc = desc }
    end

    return map
end

--- @param key_prefix string
--- @param desc_prefix string
M.generate_cmd_map = function(key_prefix, desc_prefix)
    local map = M.generate_map(key_prefix, desc_prefix)
    --- @param suffix string
    --- @param mode string|table
    --- @param cmd string
    --- @param comment string
    local cmap = function(suffix, mode, cmd, comment)
        return map(suffix, mode, function() vim.cmd(cmd) end, comment)
    end

    return cmap
end

--- @param ft_pattern string|table<string>
M.quit_with_esc = function(ft_pattern)
    vim.api.nvim_create_autocmd({ "FileType" }, {
        pattern = ft_pattern,
        group = vim.api.nvim_create_augroup("user_quit_with_esc", {}),
        callback = function()
            vim.keymap.set("n", "<esc>", vim.cmd.quit, { buffer = true, silent = true })
        end
    })
end

M.verylazy = { "VeryLazy" }
M.floatwinborder = "single"
    generate_cmd_map = generate_cmd_map,
    quit_with_esc = quit_with_esc,

return M
