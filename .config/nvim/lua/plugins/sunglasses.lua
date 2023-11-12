return {
    "miversen33/sunglasses.nvim",
    event = { "BufNewFile", "BufReadPost", "FocusLost", "WinNew" },
    config = function()
        vim.api.nvim_create_autocmd({ "FocusLost" }, {
            callback = function()
                vim.cmd("SunglassesOn")
                vim.cmd("SunglassesRefresh")
            end,
        })
        vim.api.nvim_create_autocmd({ "FocusGained" }, {
            callback = function()
                vim.cmd("SunglassesOff")
                vim.cmd("SunglassesRefresh")
            end,
        })

        require("sunglasses").setup({
            filter_type = "SHADE",
            filter_percent = .40
        })

        vim.cmd("SunglassesRefresh")
    end,
}
