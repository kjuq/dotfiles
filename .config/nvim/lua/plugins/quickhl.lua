local map = require("utils.lazy").generate_map("<leader>a", "QuickHL: ")

return {
    "t9md/vim-quickhl",
    keys = {
        map("m", { "n", "x" }, function()
            require("utils.common").feed_plug("(quickhl-manual-this)")
        end, "Mark"),
        map("M", { "n", "x" }, function()
            require("utils.common").feed_plug("(quickhl-manual-reset)")
        end, "Reset")
    }
}
