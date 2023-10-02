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
            "<leader>ln",
            mode = { "n" },
            function() vim.cmd("Noice telescope") end,
            desc = "Telescope.extensions: [l]ist [n]oice",
        },
        {
            "<C-d>",
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
            "<C-u>",
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
    opts = function ()
        require("utils.utils").quit_with_esc({ "noice" })
        return {
            lsp = {
                -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true,
                },
            },
            presets = {
                command_palette = false,          -- position the cmdline and popupmenu together
                long_message_to_split = true,     -- long messages will be sent to a split
            },
        }
    end,
    dependencies = {
        "MunifTanjim/nui.nvim",
    },
}
