local map = require("utils.lazy").generate_cmd_map("<leader>", "Mason: ")

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
    keys = {
        map("al", "n", "Mason", "Manage language servers")
    },
    config = function()
        require("mason").setup({ ui = { border = "rounded" } })
        local success, capabilities = pcall(function() require('cmp_nvim_lsp').default_capabilities() end)
        if not success then
            capabilities = nil
        end
        require("mason-lspconfig").setup({
            ensure_installed = {
                "bashls",
                "clangd",
                "lua_ls",
                "pylsp",
            },
        })
        require("mason-lspconfig").setup_handlers({
            function(server_name)
                local lspconfig = require('lspconfig')
                lspconfig[server_name].setup {
                    ---@diagnostic disable-next-line: undefined-global
                    on_attach = on_attach,
                    capabilities = capabilities,
                    -- should disable this for noice-hover-scroll
                    -- handlers = {
                    --     ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
                    --         title = " Lsp: Hover ",
                    --         max_width = 80,
                    --         max_height = 20,
                    --     }),
                    --     ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
                    --         title = " Lsp: Signature Help ",
                    --         max_width = 80,
                    --         max_height = 20,
                    --     }),
                    -- }
                }
                local macos_python_path = "/opt/homebrew/bin/python3"
                lspconfig.pylsp.setup({
                    settings = {
                        pylsp = {
                            plugins = {
                                jedi = {
                                    environment = macos_python_path,
                                }
                            }
                        }
                    }
                })
            end,
        })


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
            ensure_installed = {
                "autopep8",
                "shellcheck",
                "codelldb",
                "debugpy",
            },
            automatic_setup = true,
            handlers = {},
        })

        require("mason-nvim-dap").setup({
            handlers = {},
        })
    end,
    opts = {},
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
        "nvimtools/none-ls.nvim",
        "jay-babu/mason-null-ls.nvim",
        "jay-babu/mason-nvim-dap.nvim",
        "nvim-lua/plenary.nvim",
        "mfussenegger/nvim-dap",
    }
}
