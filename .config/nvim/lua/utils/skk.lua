local M = {}

M.skk_dir = os.getenv("XDG_CONFIG_HOME") .. "/skk"
M.jisyo_user = M.skk_dir .. "/my_jisyo"

_G._user_skk_jp_mode_enabled = false
local group = vim.api.nvim_create_augroup("user_skk_toggle", {})

---@param callback fun()
M.toggle_japanese = function(callback)
    if _G._user_skk_jp_mode_enabled then
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
    _G._user_skk_jp_mode_enabled = not _G._user_skk_jp_mode_enabled
end

---@return table
return M
