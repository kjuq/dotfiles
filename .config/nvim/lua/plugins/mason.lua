local cmap = require("utils.lazy").generate_cmd_map("<leader>", "Mason: ")

return {
    "williamboman/mason-lspconfig.nvim",
    event = require("utils.lazy").verylazy,
    config = function()
        require("core.lsp") -- load lsp config

        require("mason").setup({ ui = { border = require("utils.lazy").floatwinborder } })

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
                local lspconfig = require("lspconfig")
                local common_opts = require("plugins.lsp.common")
                lspconfig[server_name].setup(common_opts)
            end,

            ["pylsp"] = require("plugins.lsp.pylsp").setup,
            ["lua_ls"] = require("plugins.lsp.lua_ls").setup,
            ["bashls"] = require("plugins.lsp.bashls").setup,
        })

        require("null-ls").setup({})

        require("mason-null-ls").setup({
            ensure_installed = {
                "autopep8",
                "shellcheck",
                "codelldb",
                "debugpy",
            },
            automatic_installation = true,
        })

        -- for lazy-load, reload filetype
        vim.bo.filetype = vim.bo.filetype
    end,
    dependencies = {
        { "williamboman/mason.nvim", keys = { cmap("al", "n", "Mason", "Open") }, },
        "neovim/nvim-lspconfig",
        "nvimtools/none-ls.nvim",
        "jay-babu/mason-null-ls.nvim",
        "nvim-lua/plenary.nvim",
    }
}
