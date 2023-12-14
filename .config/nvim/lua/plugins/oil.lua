local map = require("utils.lazy").generate_cmd_map("<leader>", "Oil: ")
local hiddens = { ".DS_Store", ".git", ".gitmodules", "node_modules" }

---@return boolean
local is_oil_ssh = function()
    for _, arg in pairs(vim.v.argv) do
        local pattern = "oil-ssh://"
        if string.sub(arg, 1, string.len(pattern)) == pattern then
            return true
        end
    end
    return false
end

return {
    "stevearc/oil.nvim",
    lazy = not is_oil_ssh(),
    event = { "VeryLazy" },
    keys = {
        map("i", "n", "Oil", "Open"),
    },
    opts = {
        delete_to_trash = true,
        cleanup_delay_ms = 1000,
        view_options = {
            show_hidden = true,
            is_always_hidden = function(name, _)
                return vim.list_contains(hiddens, name)
            end,
        },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
}
