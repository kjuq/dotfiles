local map = require("utils.lazy").generate_cmd_map("<leader>", "Oil: ")
local hiddens = { ".DS_Store", ".git", ".gitmodules", "node_modules" }

return {
    "stevearc/oil.nvim",
    lazy = os.getenv("OILSSH") ~= nil,
    event = "VeryLazy",
    keys = {
        map("i", "n", "Oil", "Open"),
    },
    opts = {
        delete_to_trash = true,
        cleanup_delay_ms = 1000,
        keymaps = {
            ["g?"] = "actions.show_help",
            ["<CR>"] = "actions.select",
            ["<C-s>"] = "actions.select_vsplit",
            ["<C-h>"] = "actions.select_split",
            ["<C-t>"] = "actions.select_tab",
            ["dp"] = "actions.preview",
            ["<C-c>"] = "actions.close",
            ["<C-l>"] = "actions.refresh",
            ["-"] = "actions.parent",
            ["_"] = "actions.open_cwd",
            ["`"] = "actions.cd",
            ["~"] = "actions.tcd",
            ["gs"] = "actions.change_sort",
            ["gx"] = "actions.open_external",
            ["g."] = "actions.toggle_hidden",
            ["g\\"] = "actions.toggle_trash",
        },
        use_default_keymaps = false,
        view_options = {
            show_hidden = true,
            is_always_hidden = function(name, _)
                return vim.list_contains(hiddens, name)
            end,
        },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
}
