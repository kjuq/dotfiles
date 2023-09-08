return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.2",
    cmd = { "Telescope" },
    keys = {
        { "<leader>ff", mode = { "n" }, function () require("telescope.builtin").live_grep() end },
        { "<leader>fF", mode = { "n" }, function () require("telescope.builtin").find_files() end },
        { "<leader>fb", mode = { "n" }, function () require("telescope.builtin").buffers() end },
        { "<leader>fi", mode = { "n" }, function () require("telescope.builtin").help_tags() end }, -- indexes
        { "<leader>fk", mode = { "n" }, function () require("telescope.builtin").keymaps() end },
        { "<leader>fh", mode = { "n" }, function () require("telescope.builtin").oldfiles() end }, -- history
        { "<leader>fm", mode = { "n" }, function () require("telescope.builtin").man_pages() end },
        { "<leader>fr", mode = { "n" }, function () require("telescope.builtin").registers() end },
        { "<leader>fd", mode = { "n" }, function () require("telescope.builtin").diagnostics() end },
    },
    dependencies = {
        "nvim-lua/plenary.nvim",
        "BurntSushi/ripgrep",
    },
}


