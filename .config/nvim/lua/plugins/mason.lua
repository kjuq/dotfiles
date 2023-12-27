local cmap = require("utils.lazy").generate_cmd_map("<leader>", "Mason: ")

return {
    "williamboman/mason-lspconfig.nvim",
    event = { "CursorHold", "CursorHoldI" },
    config = function()
        require("lsp")
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
                lspconfig[server_name].setup({
                    ---@diagnostic disable-next-line: undefined-global
                    on_attach = on_attach,
                    capabilities = capabilities,
                    -- should disable this for noice-hover-scroll
                    _DISABLED_handlers = {
                        ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
                            title = " Lsp: Hover ",
                            border = "rounded",
                            max_width = 80,
                            max_height = 20,
                        }),
                        ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
                            title = " Lsp: Signature Help ",
                            border = "rounded",
                            max_width = 80,
                            max_height = 20,
                        }),
                    },
                })
                local python_path = os.getenv("HOMEBREW_PREFIX") .. "/bin/python3"
                lspconfig.pylsp.setup({
                    settings = {
                        pylsp = {
                            plugins = {
                                jedi = {
                                    environment = python_path,
                                }
                            }
                        }
                    }
                })
            end,
        })

        require("null-ls").setup({})

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

        -- for lazy-load, reload filetype
        vim.bo.filetype = vim.bo.filetype
    end,
    dependencies = {
        { "williamboman/mason.nvim", keys = { cmap("al", "n", "Mason", "Manage language servers") }, },
        "neovim/nvim-lspconfig",
        "nvimtools/none-ls.nvim",
        "jay-babu/mason-null-ls.nvim",
        "nvim-lua/plenary.nvim",
    }
}
