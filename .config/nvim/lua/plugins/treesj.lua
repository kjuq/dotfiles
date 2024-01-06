local map = require("utils.lazy").generate_map("", "TreeSJ: ")

return {
    "Wansmer/treesj",
    keys = {
        map("<leader>sk", "n", function() require("treesj").toggle() end, "Toggle")
    },
    config = function()
        require("treesj").setup({
            use_default_keymaps = false,
        })
    end,
    dependencies = { "nvim-treesitter/nvim-treesitter" },
}
