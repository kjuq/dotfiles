return {
    "folke/neodev.nvim",
    ft = { "lua" },
    opts = {
        library = {
            plugins = { "nvim-dap-ui" },
            types = true,
        },
    },
    dependencies = {
        "neovim/nvim-lspconfig",
    },
}
