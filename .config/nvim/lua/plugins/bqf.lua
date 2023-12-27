return {
    "kevinhwang91/nvim-bqf",
    ft = "qf",
    opts = {
        preview = {
            winblend = 0,
        },
        func_map = {
            openc = "o",
            drop = "O",
            tab = "",
            tabb = "",
            tabc = "",
            split = "",
            vsplit = "<C-s>",

            pscrollup = "<C-b>",
            pscrolldown = "<C-f>",
            pscrollorig = "zo",
            ptogglemode = "zp",
            ptoggleitem = "",
            ptoggleauto = "dp",
            filter = "zn",
            filterr = "zN",
        },
    },
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
    },
}
