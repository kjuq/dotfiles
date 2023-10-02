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
        local success, capabilities = pcall(function() require('cmp_nvim_lsp').default_capabilities() end)
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

        local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
        require("null-ls").setup({
            -- you can reuse a shared lspconfig on_attach callback here
            on_attach = function(client, bufnr)
                if client.supports_method("textDocument/formatting") then
                    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        group = augroup,
                        buffer = bufnr,
                        callback = function()
                            vim.lsp.buf.format({ async = false })
                        end,
                    })
                end
            end,
        })

        require('mason-null-ls').setup({
            automatic_setup = true,
            handlers = {},
        })
    end,
    opts = {},
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
        "nvimtools/none-ls.nvim",
        "jay-babu/mason-null-ls.nvim",
    }
}
