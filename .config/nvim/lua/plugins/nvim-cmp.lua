return {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    config = function()
        local cmp = require("cmp")
        local types = require("cmp.types")

        cmp.setup({
            snippet = {
                expand = function(args)
                    require("snippy").expand_snippet(args.body)
                end,
            },
            completion = {
                autocomplete = false,
            },

            mapping = cmp.mapping.preset.insert({
                ["<C-n>"] = cmp.mapping(function()
                    if cmp.visible() then
                        cmp.select_next_item({ behavior = types.cmp.SelectBehavior.Select })
                    else
                        cmp.complete()
                    end
                end, { "i" }),

                ["<C-p>"] = cmp.mapping(function()
                    if cmp.visible() then
                        cmp.select_prev_item({ behavior = types.cmp.SelectBehavior.Select })
                    else
                        cmp.complete()
                    end
                end, { "i" }),

                ["<C-u>"] = cmp.mapping.scroll_docs(-4),
                ["<C-d>"] = cmp.mapping.scroll_docs(4),
            }),
            sources = {
                { name = "nvim_lsp" },
                { name = "buffer" },
                { name = "path" },
                { name = "nvim_lsp_signature_help" },
                { name = "snippy" },
                { name = "nvim_lua" },
                { name = "emoji" },
                { name = "copilot" },
            },
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
            experimental = {
                ghost_text = true,
            },
        })

        -- Set configuration for specific filetype.
        cmp.setup.filetype("gitcommit", {
            sources = {
                { name = "git" }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
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
        "hrsh7th/cmp-nvim-lsp-signature-help",
        "ray-x/cmp-treesitter",
        "onsails/lspkind.nvim",
        "dcampos/cmp-snippy",
        { "zbirenbaum/copilot-cmp", opts = {}, },
        { "petertriho/cmp-git",     dependencies = "nvim-lua/plenary.nvim" }
    },
}
