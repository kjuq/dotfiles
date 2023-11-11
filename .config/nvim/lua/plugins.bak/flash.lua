local map = require("utils.lazy").generate_map("", "Flash: ")

return {
    "folke/flash.nvim",
    event = "VeryLazy",
    -- stylua: ignore
    keys = {
        { "f",  mode = { "n", "x" } },
        { "F",  mode = { "n", "x" } },
        { "t",  mode = { "n", "x" } },
        { "T",  mode = { "n", "x" } },
        { "df", mode = { "n" } },
        { "dF", mode = { "n" } },
        { "dt", mode = { "n" } },
        { "dT", mode = { "n" } },
        -- map("s", { "n", "x", "o" }, function() flash.jump() end, "Flash"),
        -- map("S", { "n", "x", "o" }, function() flash.treesitter() end, "Flash Treesitter"),
        -- map("r", { "o" }, function() flash.remote() end, "Remote Flash"),
        -- map("R", { "x", "o" }, function() flash.treesitter_search() end, "Treesitter Search"),
        -- map("<C-s>", { "c" }, function() flash.toggle() end, "Toggle Flash Search"),
    },
    ---@type Flash.Config
    opts = {
        wrap = false,
    },
}
