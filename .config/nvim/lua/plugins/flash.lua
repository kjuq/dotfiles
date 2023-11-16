local map = require("utils.lazy").generate_map("", "Flash: ")

return {
    "folke/flash.nvim",
    keys = {
        { "f",  mode = { "n", "x" } },
        { "F",  mode = { "n", "x" } },
        { "t",  mode = { "n", "x" } },
        { "T",  mode = { "n", "x" } },
        { "df", mode = { "n" },     desc = "Delete to next char" },
        { "dF", mode = { "n" },     desc = "Delete to previous char" },
        { "dt", mode = { "n" },     desc = "Delete before next char" },
        { "dT", mode = { "n" },     desc = "Delete before previous char" },
        map("<leader>af", { "n", "x", "o" }, function() require("flash").treesitter() end, "Flash Treesitter"),
        map("<leader>s", { "n", "x", "o" }, function()
            require("flash").jump({
                search = { mode = "search", max_length = 0 },
                label = { after = { 0, 0 } },
                pattern = "^"
            })
        end, "Flash"),
    },
    opts = {
        labels = "abcdefghijklmnopqrstuvwxyz",
        search = { multi_window = false, },
        label = { uppercase = false },
        highlight = { backdrop = false },
        modes = {
            search = { enabled = false },
            char = {
                multi_line = false,
                highlight = { backdrop = false }
            },
            treesitter_search = {
                search = { multi_window = false },
            },
        },
    },
}
