local map = require("utils.lazy").generate_cmd_map("", "Oil: ")
local hiddens = { ".DS_Store", ".git", ".gitmodules", "node_modules" }

return {
    "stevearc/oil.nvim",
    keys = {
        map("<leader>o", "n", "Oil", "Open parent directory"),
    },
    opts = {
        delete_to_trash = true,
        cleanup_delay_ms = 1000,
        view_options = {
            show_hidden = true,
            is_always_hidden = function(name, bufnr)
                print(name)
                return vim.list_contains(hiddens, name)
            end,
        },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
}
