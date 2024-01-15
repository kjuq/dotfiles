return {
    "akinsho/bufferline.nvim",
    version = "*",
    event = { "BufNew", "WinScrolled" },
    config = function()
        -- local transparent = "#000000"
        require("bufferline").setup({
            options = {
                numbers = "none", -- "ordinal", "buffer_id", "both"
                diagnostics = "nvim_lsp",
                always_show_bufferline = false,
                separator_style = { "|", "|" }, -- "slant", "slope", "thick", "thin", { "", "" }
                indicator = { style = "none" }, -- "icon", "underline", "none"
                show_buffer_close_icons = false,
                color_icons = true,
                offsets = {
                    {
                        filetype = "neo-tree",
                        text = "Neo Tree",
                        highlight = "Directory",
                        separator = true -- use a "true" to enable the default, or set your own character
                    },
                    {
                        filetype = "dapui_watches",
                        text = "DAP UI",
                        highlight = "Directory",
                        separator = true -- use a "true" to enable the default, or set your own character
                    },
                },
            },
            highlights = {
                separator = { fg = "#777777", },
                -- Needed when using separator
                -- fill                   = { bg = transparent, },
                -- tab_separator          = { fg = transparent, },
                -- tab_separator_selected = { fg = transparent, },
                -- separator_selected = { fg = transparent, bg =  transparent},
                -- separator_visible  = { fg = transparent, },
                -- offset_separator = { fg = transparent, },
            },
        })
    end,
    dependencies = "nvim-tree/nvim-web-devicons",
}
