return {
    "anuvyklack/help-vsplit.nvim",
    event = "InsertEnter", -- for telescope help_tag
    keys = {
        { "h", mode = "c" },
    },
    opts = {
        side = "left",
    },
}
