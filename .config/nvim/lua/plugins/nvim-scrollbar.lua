return {
    "petertriho/nvim-scrollbar",
    event = { "VeryLazy" },
    opts = {
        excluded_filetypes = {
            "cmp_docs",
            "cmp_menu",
            "dap-float",
            "noice",
            "prompt",
            "TelescopePrompt",
            "saga_codeaction",
            "sagarename",
        },
    },
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


