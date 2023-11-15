return {
    "petertriho/nvim-scrollbar",
    event = { "WinScrolled" },
    keys = {
        { "<leader>as", mode = "n", function() require("scrollbar.utils").toggle() end, desc = "Scrollbar: Toggle" },
    },
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
            local has_gitsigns, _ = pcall(require, "gitsigns")
            if has_gitsigns then
                require("scrollbar.handlers.gitsigns").setup()
            end
        end,
    },
}
