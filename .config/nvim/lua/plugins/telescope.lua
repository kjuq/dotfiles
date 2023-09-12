return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.2",
    cmd = { "Telescope" },
    keys = {
        { "<leader>fg", mode = { "n" }, function() require("telescope.builtin").live_grep() end },
        { "<leader>ff", mode = { "n" }, function() require("telescope.builtin").find_files() end },
        { "<leader>fb", mode = { "n" }, function() require("telescope.builtin").buffers() end },
        { "<leader>fi", mode = { "n" }, function() require("telescope.builtin").help_tags() end }, -- indexes
        { "<leader>fk", mode = { "n" }, function() require("telescope.builtin").keymaps() end },
        { "<leader>fh", mode = { "n" }, function() require("telescope.builtin").oldfiles() end },  -- history
        { "<leader>fm", mode = { "n" }, function() require("telescope.builtin").help_tags() end }, -- "m"an
        { "<leader>fM", mode = { "n" }, function() require("telescope.builtin").man_pages() end }, -- "m"an
        { "<leader>fr", mode = { "n" }, function() require("telescope.builtin").registers() end },
        { "<leader>fd", mode = { "n" }, function() require("telescope.builtin").diagnostics() end },
        { "<leader>fc", mode = { "n" }, function() require("telescope").extensions.zoxide.list() end },
    },
    opts = function()
        -- Useful for easily creating commands
        local z_utils = require("telescope._extensions.zoxide.utils")

        return {
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
        "jvgrootveld/telescope-zoxide",
    },
}
