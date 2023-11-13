local map = require("utils.lazy").generate_cmd_map("<leader>", "Aerial: ")

return {
    "stevearc/aerial.nvim",
    keys = {
        map("to", "n", "AerialToggle", "Toggle")
    },
    opts = {
        backends = { "lsp", "treesitter", "markdown", "man" },
        keymaps = {
            ["<Esc>"] = "actions.close",
        },
        show_guides = true,
    },
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons"
    },
}
