return {
    "folke/noice.nvim",
    event = { "InsertEnter", "CmdlineEnter", "BufNewFile", "BufReadPost" },
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
            "<leader>hn",
            mode = { "n" },
            function() vim.cmd("Noice telescope") end,
            desc = "Telescope.extensions: [h]istory of [n]oice",
        },
        {
            "<C-d>",
            mode = { "n", "i", "s" },
            function()
                if not require("noice.lsp").scroll(4) then
                    return "<c-d>"
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
                    return "<c-u>"
                end
            end,
            silent = true,
            expr = true,
        },
    },
    opts = function()
        require("utils.common").quit_with_esc({ "noice" })
        return {
            lsp = {
                hover = {
                    opts = {
                        format = { "{message}", "\n\nProvided by Noice - Hover", },
                    },
                },
                signature = {
                    opts = {
                        format = { "{message}", "\n\nProvided by Noice - Signature Help" },
                    },
                    auto_open = { enabled = false },
                },
                documentation = {
                    opts = {
                        border = "rounded",
                        position = { row = 2, col = 2 },
                        size = {
                            max_width = 80,
                            max_height = 20,
                        },
                    },
                },
                -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true,
                },
            },
            presets = {
                command_palette = false,      -- position the cmdline and popupmenu together
                long_message_to_split = true, -- long messages will be sent to a split
                -- lsp_doc_hover = true,
            },
        }
    end,
    dependencies = {
        "MunifTanjim/nui.nvim",
    },
}
