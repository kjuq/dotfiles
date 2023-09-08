return {
    "L3MON4D3/LuaSnip",
    tag = "v2.0.0",
    keys = {
        {
            "<Tab>",
            mode = { "i", "s" },
            function () require("luasnip").expand_or_jump() end,
            { silent = true },
        },
        {
            "<S-Tab>",
            mode = { "i", "s" },
            function () require("luasnip").jump(-1) end,
            { silent = true },
        },
    },
    config = function ()
        require("luasnip.loaders.from_snipmate").lazy_load()
    end,
}

