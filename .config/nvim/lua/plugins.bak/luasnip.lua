return {
    "L3MON4D3/LuaSnip",
    tag = "v2.0.0",
    keys = {
        {
            "<Tab>",
            mode = { "i", "s" },
            function()
                if require("luasnip").expand_or_jumpable() then
                    require("luasnip").expand_or_jump()
                else
                    local key = vim.api.nvim_replace_termcodes("<Tab>", true, false, true)
                    vim.api.nvim_feedkeys(key, "n", false)
                end
            end,
            desc = "LuaSnip: expand or jump to a next placeholder",
            { silent = true },
        },
        {
            "<S-Tab>",
            mode = { "i", "s" },
            function()
                if require("luasnip").expand_or_jumpable() then
                    require("luasnip").jump(-1)
                else
                    local key = vim.api.nvim_replace_termcodes("<S-Tab>", true, false, true)
                    vim.api.nvim_feedkeys(key, "n", false)
                end
            end,
            desc = "LuaSnip: jump to a previous placeholder",
            { silent = true },
        },
    },
    config = function()
        require("luasnip.loaders.from_snipmate").lazy_load()
    end,
}
