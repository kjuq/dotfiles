return {
    'akinsho/bufferline.nvim',
    version = "*",
    event = { "BufNewFile", "BufReadPost" },
    dependencies = 'nvim-tree/nvim-web-devicons',
    opts = {
        options = {
            diagnostics = "nvim_lsp",
            always_show_bufferline = true,
            separator_style = "slant",
            show_buffer_close_icons = false,
            color_icons = true,
        },
    },
}


