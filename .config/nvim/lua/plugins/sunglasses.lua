return {
    "miversen33/sunglasses.nvim",
    event = { "BufNewFile", "BufReadPost", "FocusLost", "WinNew" },
    config = function()
        local unfocused = vim.api.nvim_create_augroup("sunglasses_unfocuesd", {})
        vim.api.nvim_create_autocmd({ "FocusLost" }, {
            group = unfocused,
            callback = function()
                vim.cmd("SunglassesOn")
                vim.cmd("SunglassesRefresh")
            end,
        })
        local focused = vim.api.nvim_create_augroup("sunglasses_focused", {})
        vim.api.nvim_create_autocmd({ "FocusGained" }, {
            group = focused,
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
