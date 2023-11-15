local map = require("utils.lazy").generate_map("<leader>", "Bufdelete: ")

return {
    "famiu/bufdelete.nvim",
    cmd = { "Bdelete", "Bwipeout" },
    keys = {
        map("x", "n", function() require("bufdelete").bufdelete(0, false) end, "Delete buffer"),
        map("X", "n", function() require("bufdelete").bufdelete(0, true) end, "Delete buffer forcibly"),
    },
}
