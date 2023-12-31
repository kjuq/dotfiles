---@return table { skk_dir = string, jisyo_l = string, toggle_japanese = fun(opts: table, group: integer, callback: fun()) }
return {
    skk_dir = os.getenv("XDG_CONFIG_HOME") .. "/skk",
    jisyo_user = os.getenv("XDG_CONFIG_HOME") .. "/skk/my_jisyo",
    jisyo_l = os.getenv("HOMEBREW_PREFIX") .. "/share/skk-jisyo-l/SKK-JISYO.L",

    ---@param opts table { enabled = boolean }
    ---@param group integer
    ---@param callback fun()
    toggle_japanese = function(opts, group, callback)
        if opts.enabled then
            print("Japanese mode disabled")
            vim.api.nvim_clear_autocmds({ group = group })
        else
            print("Japanese mode enabled")
            vim.api.nvim_create_autocmd("InsertEnter", {
                group = group,
                pattern = "*",
                callback = callback,
            })
        end
        opts.enabled = not opts.enabled
    end
}
