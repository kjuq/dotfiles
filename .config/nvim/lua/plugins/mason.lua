local cmap = require("utils.lazy").generate_cmd_map("<leader>", "Mason: ")
local map = require("utils.lazy").generate_map("<leader>", "Mason: ")

return {
    "williamboman/mason.nvim",
    event = { "CursorMoved", "ModeChanged" },
    cmd = {
        "Mason",
        "MasonInstall",
        "MasonUninstall",
        "MasonUninstallAll",
        "MasonLog",
        "MasonUpdate",
    },
    keys = {
        cmap("al", "n", "Mason", "Manage language servers"),
        map("ar", "n", function() vim.bo.filetype = vim.bo.filetype end, "Attach language server"),
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

        require("mason-nvim-dap").setup({
            handlers = {},
        })

        -- for lazy-load, reload filetype
        vim.bo.filetype = vim.bo.filetype
    end,
    dependencies = {
        "neovim/nvim-lspconfig",
        "williamboman/mason-lspconfig.nvim",
        "nvimtools/none-ls.nvim",
        "jay-babu/mason-null-ls.nvim",
        "jay-babu/mason-nvim-dap.nvim",
        "nvim-lua/plenary.nvim",
        "mfussenegger/nvim-dap",
    }
}
