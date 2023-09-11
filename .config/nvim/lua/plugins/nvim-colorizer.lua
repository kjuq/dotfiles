return {
    "norcalli/nvim-colorizer.lua",
    event = { "BufNewFile", "BufReadPost" },
    config = function ()
        require("colorizer").setup()
    end,
}


