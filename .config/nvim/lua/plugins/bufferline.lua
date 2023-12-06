return {
    "akinsho/bufferline.nvim",
    version = "*",
    event = { "BufNew", "WinScrolled" },
    config = function()
        require("bufferline").setup({
            options = {
                numbers = "ordinal",
                diagnostics = "nvim_lsp",
                always_show_bufferline = false,
                separator_style = { "", "" }, -- "slant", "slope", "thick", "thin"
                indicator = {
                    style = "none",           -- "icon", "underline", "none"
                },
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
            -- Needed when separator is used
            -- highlights = {
            --     fill                   = { bg = "#000000", },
            --     tab_separator          = { fg = "#000000", },
            --     tab_separator_selected = { fg = "#000000", },
            --     separator_selected     = { fg = "#000000", bg = "#000000" },
            --     separator_visible      = { fg = "#000000", },
            --     separator              = { fg = "#000000", },
            --     offset_separator       = { fg = "#000000", },
            -- },
        })
    end,
    dependencies = "nvim-tree/nvim-web-devicons",
}
