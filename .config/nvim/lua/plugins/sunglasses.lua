return {
    "miversen33/sunglasses.nvim",
    event = { "BufNewFile", "BufReadPost" },
    opts = {
        filter_type = "NOSYNTAX",
        filter_percent = .65
    },
}
