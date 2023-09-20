return {
    'akinsho/bufferline.nvim',
    event = { "VeryLazy" },
    opts = {
        options = {
            diagnostics = "nvim_lsp",
            always_show_bufferline = true,
            separator_style = "slant",
            show_buffer_close_icons = false,
            color_icons = true,
        },
    },
    version = "*",
    dependencies = 'nvim-tree/nvim-web-devicons',
}


