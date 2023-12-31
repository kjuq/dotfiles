--- @param key_prefix string
--- @param desc_prefix string
local generate_map = function(key_prefix, desc_prefix)
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
local generate_cmd_map = function(key_prefix, desc_prefix)
    local map = generate_map(key_prefix, desc_prefix)
    --- @param suffix string
    --- @param mode string|table
    --- @param cmd string
    --- @param comment string
    local cmap = function(suffix, mode, cmd, comment)
        return map(suffix, mode, function() vim.cmd(cmd) end, comment)
    end

    return cmap
end

--- @param ft table<string>
local quit_with_esc = function(ft)
    vim.api.nvim_create_autocmd({ "filetype" }, {
        pattern = ft,
        callback = function()
            vim.keymap.set("n", "<esc>", vim.cmd.quit, { buffer = true, silent = true })
        end
    })
end

return {
    generate_map = generate_map,
    generate_cmd_map = generate_cmd_map,
    quit_with_esc = quit_with_esc,
    -- verylazy = { "CursorHold", "CursorHoldI" },
    verylazy = { "VeryLazy" },
    floatwinborder = "single",
}
