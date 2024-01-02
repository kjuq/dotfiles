local cmap = require("utils.lazy").generate_cmd_map("<leader>", "Mason: ")

return {
    "williamboman/mason-lspconfig.nvim",
    event = require("utils.lazy").verylazy,
    config = function()
        require("lsp")
        require("mason").setup({ ui = { border = require("utils.lazy").floatwinborder } })

        local success, capabilities = pcall(function() require("cmp_nvim_lsp").default_capabilities() end)
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

        local common_opts = {
            capabilities = capabilities,
            _handlers = { -- this is now disabled to use noice-hover-scroll
                ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
                    title = " Lsp: Hover ",
                    border = require("utils.lazy").floatwinborder,
                    max_width = 80,
                    max_height = 20,
                }),
                ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
                    title = " Lsp: Signature Help ",
                    border = require("utils.lazy").floatwinborder,
                    max_width = 80,
                    max_height = 20,
                }),
            },
        }

        local lspconfig = require("lspconfig")

        require("mason-lspconfig").setup_handlers({
            function(server_name)
                ---@diagnostic disable-next-line: undefined-field
                lspconfig[server_name].setup(common_opts)
            end,

            ["pylsp"] = function()
                local python_path = os.getenv("HOMEBREW_PREFIX") .. "/bin/python3"
                lspconfig.pylsp.setup(vim.tbl_deep_extend("error", common_opts, {
                    settings = { pylsp = { plugins = { jedi = { environment = python_path } } } },
                }))
            end,

            -- https://github.com/uhooi/dotfiles/blob/09d5f8f03974e4ef8ecf6641a0801d8b60271fca/.config/nvim/lua/plugins/config/nvim_lspconfig.lua
            -- https://github.com/uhooi/dotfiles/blob/09d5f8f03974e4ef8ecf6641a0801d8b60271fca/.config/nvim/lua/plugins/config/lsp/lua_ls.lua
            ["lua_ls"] = function()
                lspconfig.lua_ls.setup(vim.tbl_deep_extend("error", common_opts, {
                    settings = {
                        Lua = {
                            runtime = { version = "LuaJIT" },
                            diagnostics = { globals = { "vim" } },
                            workspace = {
                                checkThirdParty = "Disable",
                                library = {
                                    vim.env.VIMRUNTIME,
                                    "${3rd}/luv/library",
                                    "${3rd}/busted/library",
                                },
                                -- library = vim.api.nvim_get_runtime_file("", true), -- This is a lot slower
                            },
                            -- format = { enable = false } , -- Use StyLua if disabled
                            telemetry = { enable = false },
                            hint = { enable = true },
                        },
                    },
                }))
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
            automatic_installation = true,
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
