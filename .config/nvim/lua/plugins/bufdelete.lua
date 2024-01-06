local map = require("utils.lazy").generate_map("", "Bufdelete: ")

return {
    "famiu/bufdelete.nvim",
    cmd = { "Bdelete", "Bwipeout" },
    keys = {
        map("gl", "n", function() require("bufdelete").bufdelete(0, false) end, "Delete buffer"),
        map("<leader>x", "n", function() require("bufdelete").bufdelete(0, false) end, "Delete buffer"),
        map("gL", "n", function() require("bufdelete").bufdelete(0, true) end, "Delete buffer forcibly"),
        map("<leader>X", "n", function() require("bufdelete").bufdelete(0, true) end, "Delete buffer forcibly"),
    },
}
