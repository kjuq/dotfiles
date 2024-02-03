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

M.mappings = function(enable, disable, toggle)
    local map = require("utils.lazy").generate_map("", "Skkeleton: ")
    local skk = require("utils.skk")
    local toggle_japanese = function()
        skk.toggle_japanese(function()
            require("utils.common").feed_plug(enable)
        end)
    end
    return {
        map("<C-Space>", { "i", "c" }, function() require("utils.common").feed_plug(toggle) end, "Toggle"),
        map("<leader>aj", "n", function() toggle_japanese() end, "Toggle JP mode"),
        map("<F19>", { "i", "c" }, function() require("utils.common").feed_plug(enable) end, "Enable"),
        map("<F18>", { "i", "c" }, function() require("utils.common").feed_plug(disable) end, "Disable"),
        map("<C-g>j", "i", function()
            if _G._user_skk_jp_mode_enabled then
                require("utils.common").feed_plug(disable)
            else
                require("utils.common").feed_plug(enable)
            end
            toggle_japanese()
        end, "Toggle JP mode"),
    }
end

---@return table
return M
