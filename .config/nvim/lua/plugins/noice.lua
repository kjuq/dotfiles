return {
    "folke/noice.nvim",
    event = "VeryLazy",
    cmd = {
        "Noice",
        "NoiceLog",
        "NoiceLast",
        "NoiceDebug",
        "NoiceStats",
        "NoiceConfig",
        "NoiceEnable",
        "NoiceErrors",
        "NoiceRoutes",
        "NoiceDisable",
        "NoiceDismiss",
        "NoiceHistory",
        "NoiceTelescope",
        "NoiceViewstats",
    },
    keys = {
        { "<leader>fn", mode = { "n" }, function () vim.cmd("Noice telescope") end },
    },
    config = function ()
        vim.keymap.set({"n", "i", "s"}, "<c-f>", function()
            if not require("noice.lsp").scroll(4) then
                return "<c-f>"
            end
        end, { silent = true, expr = true })

        vim.keymap.set({"n", "i", "s"}, "<c-b>", function()
            if not require("noice.lsp").scroll(-4) then
                return "<c-b>"
            end
        end, { silent = true, expr = true })

        require("noice").setup({})
    end,
    dependencies = {
        "MunifTanjim/nui.nvim",
        {
            "rcarriga/nvim-notify",
            config = function ()
                local Esc = function ()
                    require('notify').dismiss()
                end
                Escs[#Escs + 1] = Esc
                vim.keymap.set("n", "<Esc>", Exec_Escs, { silent = true })

                require("notify").setup({
                    fps = 60,
                    timeout = 800,
                    stages = "fade",
                })
            end
        },
    },
}


