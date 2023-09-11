return {
    "HiPhish/rainbow-delimiters.nvim",
    event = { "BufNewFile", "BufReadPost" },
    config = function ()
        local rainbow = require("rainbow-delimiters")

        vim.g.rainbow_delimiters = {
            strategy = {
                [''] = function ()
                    if vim.fn.line('$') > 10000 then
                        return nil
                    elseif vim.fn.line('$') > 1000 then
                        return rainbow.strategy['global']
                    end
                    return rainbow.strategy['local']
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


