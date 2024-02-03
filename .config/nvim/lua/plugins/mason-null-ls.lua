return {
    "jay-babu/mason-null-ls.nvim",
    event = "LspAttach",
    opts = {
        ensure_installed = {
            "autopep8",
            "shellcheck",
            "codelldb",
            "debugpy",
        },
        automatic_installation = true,
    },
    dependencies = {
        "williamboman/mason.nvim",
        "nvimtools/none-ls.nvim",
    },
}
