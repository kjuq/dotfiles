return {
    "bennypowers/nvim-regexplainer",
    event = "CursorHold",
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
