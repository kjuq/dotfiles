local map = require("utils.lazy").generate_map("<leader>", "Neo-tree: ")

return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    cmd = { "Neotree" },
    keys = {
        map("y", "n", function()
            require("neo-tree.command").execute({
                source = "filesystem",
                position = "float",
                toggle = true,
                reveal_force_cwd = true,
            })
        end, "Open"),
        map("at", "n", function()
            require("neo-tree.command").execute({
                source = "filesystem",
                position = "left",
                toggle = false,
                reveal_force_cwd = true,
            })
        end, "Open on left"),
        map("ag", "n", function()
            require("neo-tree.command").execute({
                source = "git_status",
                position = "left",
                toggle = false,
                reveal_force_cwd = true,
            })
        end, "Open git on left"),
        map("ab", "n", function()
            require("neo-tree.command").execute({
                source = "buffers",
                position = "left",
                toggle = false,
                reveal_force_cwd = true,
            })
        end, "Open buffer on left"),
    },
    opts = {
        close_if_last_window = true,
        window = {
            mappings = {
                ["<M-f>"] = function() vim.api.nvim_exec2("Neotree focus filesystem", { output = true }) end,
                ["<M-b>"] = function() vim.api.nvim_exec2("Neotree focus buffers", { output = true }) end,
                ["<M-g>"] = function() vim.api.nvim_exec2("Neotree focus git_status", { output = true }) end,
            },
        },
        filesystem = {
            window = {
                mappings = {
                    ["<C-h>"] = "navigate_up",
                },
            },
            follow_current_file = {
                enabled = true,
            },
            filtered_items = {
                visible = true, -- when true, they will just be displayed differently than normal items
                hide_dotfiles = false,
                hide_gitignored = true,
                hide_by_name = {
                    "node_modules",
                },
                hide_by_pattern = { -- uses glob style patterns
                    --"*.meta",
                    --"*/src/*/tsconfig.json",
                },
                always_show = { -- remains visible even if other settings would normally hide it
                    --".gitignored",
                },
                never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
                    ".DS_Store",
                },
                never_show_by_pattern = { -- uses glob style patterns
                    --".null-ls_*",
                },
            },
            hijack_netrw_behavior = "disabled",
            use_libuv_file_watcher = true,
        },
        git_status = {
        },
        buffers = {
            window = {
                mappings = {
                    ["<C-h>"] = "navigate_up",
                },
            },
            follow_current_file = {
                enabled = true,
            },
        },
    },
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
}
