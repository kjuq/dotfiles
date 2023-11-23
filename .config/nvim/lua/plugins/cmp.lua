return {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    config = function()
        -- max height of floating cmp window
        vim.opt.pumheight = 8

        local cmp = require("cmp")
        local types = require("cmp.types")
        local modes_is = { "i", "s" }

        cmp.setup({
            -- completion = { autocomplete = false }, -- `true` is invalid option
            experimental = { ghost_text = true },

            snippet = { expand = function(args) require("snippy").expand_snippet(args.body) end },

            mapping = cmp.mapping.preset.insert({
                ["<C-n>"] = cmp.mapping(function()
                    if cmp.visible() then
                        cmp.select_next_item({ behavior = types.cmp.SelectBehavior.Select })
                    else
                        cmp.complete()
                    end
                end, modes_is),

                ["<C-p>"] = cmp.mapping(function()
                    if cmp.visible() then
                        cmp.select_prev_item({ behavior = types.cmp.SelectBehavior.Select })
                    else
                        cmp.complete()
                    end
                end, modes_is),

                ["<C-l>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.abort()
                    else
                        fallback()
                    end
                end, modes_is),

                ["<C-u>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.scroll_docs(-4)
                    else
                        fallback()
                    end
                end, modes_is),

                ["<C-d>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.scroll_docs(4)
                    else
                        fallback()
                    end
                end, modes_is),
            }),
            sources = cmp.config.sources({
                pcall(require, "plugins.skkeleton")
                --[[-]] and require("plugins.skkeleton").cond
                --[[-]] and { name = "skkeleton" }
                --[[-]] or {},
            }, {
                { name = "copilot" }, --,  priority = -1 },
                { name = "path" },
                { name = "emoji" },
                { name = "snippy" },
                { name = "nvim_lsp" },
                { name = "nvim_lua" },
                { name = "buffer" },
            }),
            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            formatting = {
                format = require("lspkind").cmp_format({
                    mode = "text_symbol",  -- show only symbol annotations
                    maxwidth = 50,         -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
                    ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
                    symbol_map = { Copilot = "" }
                })
            },
        })

        -- Set configuration for specific filetype.
        cmp.setup.filetype("gitcommit", {
            sources = {
                { name = "git" },
                { name = "buffer" },
            },
        })

        -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline({ "/", "?" }, {
            completion = { autocomplete = false },
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = "buffer" },
            },
        })

        -- Use cmdline & path source for ":" (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline(":", {
            completion = { autocomplete = false },
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                { name = "path" },
                { name = "cmdline" },
            }
        })
    end,
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-emoji",
        "ray-x/cmp-treesitter",
        "onsails/lspkind.nvim",
        "dcampos/cmp-snippy",
        { "zbirenbaum/copilot-cmp", event = { "LspAttach" },               opts = {}, },
        { "petertriho/cmp-git",     dependencies = "nvim-lua/plenary.nvim" },
        "uga-rosa/cmp-skkeleton",
    },
}
