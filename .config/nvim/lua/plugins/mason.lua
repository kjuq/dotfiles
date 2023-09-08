return {
    "williamboman/mason.nvim",
    event = { "BufNewFile", "BufReadPost" },
    cmd = {
        "Mason",
        "MasonInstall",
        "MasonUninstall",
        "MasonUninstallAll",
        "MasonLog",
        "MasonUpdate",
    },
    config = function()
        local success, capabilities = pcall(function () require('cmp_nvim_lsp').default_capabilities() end)
        if not success then
            capabilities = nil
        end
        require("mason-lspconfig").setup_handlers({
            function(server_name)
                require('lspconfig')[server_name].setup {
                    capabilities = capabilities,
                }
            end,
        })
        require("mason-lspconfig").setup({})
        require("mason").setup({})
    end,
    opts = {},
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
    }
}


