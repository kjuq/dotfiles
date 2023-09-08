return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    cmd = {
        "Neotree",
    },
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    opts = {
        close_if_last_window = true,
        window = {
            mappings = {
                    ["<C-h>"] = "navigate_up",
                },
            },
    },
    keys = {
        { "<C-Space>", mode = { "n", "i" }, "<Cmd>Neotree source=filesystem position=float toggle=true reveal_force_cwd=true<CR>" },
        { "<leader>tt", mode = "n", "<Cmd>Neotree source=filesystem position=float toggle=true<CR>" },
        { "<leader>ts", mode = "n", "<Cmd>Neotree source=filesystem position=left<CR>" },
    },
}

