local map = require("utils.lazy").generate_cmd_map("<leader>a", "CCC: ")

return {
    "uga-rosa/ccc.nvim",
    event = require("utils.lazy").verylazy,
    keys = {
        map("r", "n", "CccPick", "Open picker"),
    },
    opts = {
        highlighter = {
            auto_enable = true,
        },
    },
}
