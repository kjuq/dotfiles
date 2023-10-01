return {
    "folke/noice.nvim",
    event = { "VeryLazy" },
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
        {
            "<leader>fn",
            mode = { "n" },
            function () vim.cmd("Noice telescope") end,
            desc = "Telescope.extensions: [n]oice",
        },
        {
            "<C-f>",
            mode = { "n", "i", "s" },
            function()
                if not require("noice.lsp").scroll(4) then
                    return "<c-f>"
                end
            end,
            silent = true,
            expr = true,
        },
        {
            "<C-b>",
            mode = { "n", "i", "s" },
            function()
                if not require("noice.lsp").scroll(-4) then
                    return "<c-f>"
                end
            end,
            silent = true,
            expr = true,
        },
    },
    opts = {
        messages = {
            enabled = true, -- enables the Noice messages UI
            view = "mini", -- default view for messages
            view_error = "mini", -- view for errors
            view_warn = "mini", -- view for warnings
            view_history = "messages", -- view for :messages
            view_search = "virtualtext", -- view for search count messages. Set to `false` to disable
        },
    },
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

                vim.keymap.set("n", "<C-w><C-w>", function()
                    local key = vim.api.nvim_replace_termcodes("<C-w>", true, false, true)
                    require('notify').dismiss()
                    vim.api.nvim_feedkeys(key, "n", false)
                    vim.api.nvim_feedkeys(key, "n", false)
                end, { silent = true })

                require("notify").setup({
                    fps = 60,
                    -- timeout = 800,
                    stages = "fade",
                })
            end
        },
    },
}


