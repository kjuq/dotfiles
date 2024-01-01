return {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
        map_cr = false,
        map_c_h = true,
        map_c_w = true,
        check_ts = true, -- treesitter
    },
}
