local M = {}

M.skk_dir = os.getenv("XDG_CONFIG_HOME") .. "/skk"
M.jisyo_user = M.skk_dir .. "/my_jisyo"
M.jisyo_l = os.getenv("HOMEBREW_PREFIX") .. "/share/skk-jisyo-l/SKK-JISYO.L"

---@return boolean
M.jisyo_l_exists = function()
    if vim.fn.filereadable(M.jisyo_l) == 1 then
        return true
    else
        print(M.jisyo_l .. " is not installed")
        print("SKK is temporarily disabled")
        return false
    end
end

_G._user_skk_toggle_state = false
local group = vim.api.nvim_create_augroup("user_skk_toggle", {})

---@param callback fun()
M.toggle_japanese = function(callback)
    if _G._user_skk_toggle_state then
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
    _G._user_skk_toggle_state = not _G._user_skk_toggle_state
end

---@return table
return M
