return {
    "HiPhish/rainbow-delimiters.nvim",
    event = { "BufNewFile", "BufReadPost" },
    config = function ()
        local rainbow = require("rainbow-delimiters")

        vim.g.rainbow_delimiters = {
            strategy = {
                [''] = function ()
                    if vim.fn.line('$') > 3000 then
                        return rainbow.strategy['local']
                    else
                        return rainbow.strategy['global']
                    end
                end,
            },
            highlight = {
                -- From plugins/indent-blankline.lua
                "IndentBlanklineIndent1",
                "IndentBlanklineIndent2",
                "IndentBlanklineIndent3",
                "IndentBlanklineIndent4",
                "IndentBlanklineIndent5",
                "IndentBlanklineIndent6",
            },
        }
    end,
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
    },
}


