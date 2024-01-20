local map = require("utils.lazy").generate_map("", "Todo: ")

return {
    "folke/todo-comments.nvim",
    event = require("utils.lazy").verylazy,
    keys = {
        map("]t", "n", function() require("todo-comments").jump_next() end, "Next todo comment"),
        map("[t", "n", function() require("todo-comments").jump_prev() end, "Previous todo comment"),
    },
    opts = {
        signs = false,
    },
    dependencies = { "nvim-lua/plenary.nvim" },
}
