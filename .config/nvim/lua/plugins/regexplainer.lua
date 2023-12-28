return {
    "bennypowers/nvim-regexplainer",
    event = require("utils.lazy").verylazy,
    config = function()
        require("regexplainer").setup({
            auto = true,
            mappings = {
                toggle = "", -- disable gR which is the default keymap
            },
            popup = {
                border = {
                    padding = { 0, 1 },
                    style = "rounded",
                }
            }
        })
    end,
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "MunifTanjim/nui.nvim",
    },
}
