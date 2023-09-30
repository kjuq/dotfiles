return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    event = { "VeryLazy" },
    cmd = {
        "Neotree",
    },
    keys = {
        {
            "<C-Space>",
            mode = { "n" },
            "<Cmd>Neotree source=filesystem position=float toggle=true reveal_force_cwd<CR>",
            desc = "Neo-tree: open a floating window",
        },
        {
            "<leader>ts",
            mode = { "n" },
            "<Cmd>Neotree source=filesystem position=left reveal_force_cwd<CR>",
            desc = "Neo-tree: open a side window on left",
        },
    },
    opts = {
        close_if_last_window = true,
        window = {
            mappings = {
                ["<C-h>"] = "navigate_up",
            },
        },
        filesystem = {
            filtered_items = {
                hide_dotfiles = false,
            },
            hijack_netrw_behavior = "open_current",
        },
    },
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
}


