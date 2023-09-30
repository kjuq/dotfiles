return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.3",
    cmd = { "Telescope" },
    keys = {
        {
            "<leader>fg",
            mode = { "n" },
            function () require("telescope.builtin").live_grep() end,
            desc = "Telescope.builtin: Live grep"
        },
        {
            "<leader>ff",
            mode = { "n" },
            function () require("telescope.builtin").find_files({ hidden = true }) end,
            "Telescope.builtin: Find files"
        },
        {
            "<leader>fb",
            mode = { "n" },
            function () require("telescope.builtin").buffers() end,
            desc = "Telescope.builtin: Buffers"
        },
        {
            "<leader>fi",
            mode = { "n" },
            function () require("telescope.builtin").help_tags() end,
            desc = "Telescope.builtin: Help tags (\"i\"ndex)"
        },
        {
            "<leader>fk",
            mode = { "n" },
            function () require("telescope.builtin").keymaps() end,
            desc = "Telescope.builtin: Keymaps"
        },
        {
            "<leader>fh",
            mode = { "n" },
            function () require("telescope.builtin").oldfiles() end,
            desc = "Telescope.builtin: Old files (\"h\"istory)"
        },
        {
            "<leader>fm",
            mode = { "n" },
            function () require("telescope.builtin").man_pages() end,
            desc = "Telescope.builtin: Man pages"
        },
        {
            "<leader>fr",
            mode = { "n" },
            function () require("telescope.builtin").registers() end,
            desc = "Telescope.builtin: Registers"
        },
        {
            "<leader>fd",
            mode = { "n" },
            function () require("telescope.builtin").diagnostics() end,
            desc = "Telescope.builtin: Diagnostics"
        },
        {
            "<leader>fs",
            mode = { "n" },
            function ()
                require("telescope.builtin").symbols {
                    sources = { "emoji", "kaomoji", "gitmoji", "nerd" }
                }
            end,
            desc = "Telescope.builtin: Symbols",
        },
        {
            "<leader>fc",
            mode = { "n" },
            function () require("telescope").extensions.zoxide.list() end,
            desc = "Telescope.extensions: Zoxide list (\"c\"d)"
        },
    },
    opts = function ()
        local actions = require("telescope.actions")
        local z_utils = require("telescope._extensions.zoxide.utils")

        return {
            defaults = {
                mappings = {
                    i = {
                        ["<esc>"] = actions.close,
                        ["<C-c>"] = { "<esc>", type = "command" },
                    },
                },
            },
            extensions = {
                zoxide = {
                    prompt_title = "[ Walking on the shoulders of TJ ]",
                    mappings = {
                        default = {
                            after_action = function(selection)
                                print("Update to (" .. selection.z_score .. ") " .. selection.path)
                            end
                        },
                        ["<C-s>"] = {
                            before_action = function(selection) print("before C-s") end,
                            action = function(selection)
                                vim.cmd.edit(selection.path)
                            end
                        },
                        -- Opens the selected entry in a new split
                        ["<C-q>"] = { action = z_utils.create_basic_command("split") },
                    },
                }
            }
        }
    end,
    dependencies = {
        "nvim-lua/popup.nvim",
        "nvim-lua/plenary.nvim",
        "BurntSushi/ripgrep",
        "nvim-telescope/telescope-symbols.nvim",
        "jvgrootveld/telescope-zoxide",
    },
}


