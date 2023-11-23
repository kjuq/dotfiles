local map = require("utils.lazy").generate_map("<leader>r", "Persistence: ")

return {
    "folke/persistence.nvim",
    event = "BufReadPre", -- this will only start session saving when an actual file was opened
    keys = {
        -- restore the session for the current directory
        map("s", "n", function() require("persistence").load() end, "Restore the session for the current directory"),

        -- restore the last session
        map("l", "n", function() require("persistence").load({ last = true }) end, "Restore the last session"),

        -- stop Persistence => session won't be saved on exit
        map("d", "n", function() require("persistence").stop() end, "Stop saving session on exit"),
    },
    opts = {
    }
}
