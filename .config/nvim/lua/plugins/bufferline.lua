return {
    'akinsho/bufferline.nvim',
    version = "*",
    event = { "CursorHold" },
    dependencies = 'nvim-tree/nvim-web-devicons',
    opts = {
        options = {
            diagnostics = "nvim_lsp",
            always_show_bufferline = false,
            separator_style = "slant",
            show_buffer_close_icons = false,
            color_icons = true,
        },
    },
}


