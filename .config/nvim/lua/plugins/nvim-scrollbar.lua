return {
    "petertriho/nvim-scrollbar",
    event = { "CursorHold" },
    opts = {},
    dependencies = {
        "kevinhwang91/nvim-hlslens",
        config = function()
            require("scrollbar.handlers.search").setup({
                override_lens = function() end,
            })
            require("scrollbar.handlers.gitsigns").setup()
        end,
    },
}


