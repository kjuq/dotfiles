return {
    "L3MON4D3/LuaSnip",
    tag = "v2.0.0",
    _keys = {
        {
            "<Tab>",
            mode = { "i", "s" },
            function ()
                if require("luasnip").expand_or_jumpable() then
                    require("luasnip").expand_or_jump()
                else
                    local key = vim.api.nvim_replace_termcodes("<Tab>", true, false, true)
                    vim.api.nvim_feedkeys(key, "n", false)
                end
            end,
            { silent = true },
        },
        {
            "<S-Tab>",
            mode = { "i", "s" },
            function ()
                if require("luasnip").expand_or_jumpable() then
                    require("luasnip").jump(-1)
                else
                    local key = vim.api.nvim_replace_termcodes("<S-Tab>", true, false, true)
                    vim.api.nvim_feedkeys(key, "n", false)
                end
            end,
            { silent = true },
        },
    },
    config = function ()
        require("luasnip.loaders.from_snipmate").lazy_load()
    end,
}

