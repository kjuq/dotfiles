return {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
        map_cr = false,
        map_c_h = true,
        map_c_w = true,
        break_undo = false,
        check_ts = true, -- treesitter
        fast_wrap = {
            map = "<C-g>e",
            keys = "arstneioghwfpluy",
        },
    },
}
