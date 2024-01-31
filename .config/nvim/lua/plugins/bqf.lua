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

            pscrollup = require("utils.lazy").floatscrollup,
            pscrolldown = require("utils.lazy").floatscrolldown,
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
