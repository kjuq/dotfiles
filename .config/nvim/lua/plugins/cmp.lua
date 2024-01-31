return {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    config = function()
        -- max height of floating cmp window
        vim.opt.pumheight = 8

        local cmp = require("cmp")
        local types = require("cmp.types")

        local copilot_source = cmp.config.sources({ { name = "copilot" } })
        local normal_sources = cmp.config.sources({
            pcall(require, "plugins.skkeleton")
            --[[-]] and require("plugins.skkeleton").cond
            --[[-]] and { name = "skkeleton" }
            --[[-]] or {},
        }, {
            { name = "path" },
            { name = "emoji" },
            { name = "luasnip" },
            { name = "nvim_lsp" },
            { name = "nvim_lua" },
            { name = "buffer",  max_item_count = 2 },
            { name = "natdat" },
        })

        local select_next = function()
            if cmp.visible() then
                cmp.select_next_item({ behavior = types.cmp.SelectBehavior.Select })
            else
                cmp.setup({ sources = normal_sources })
                cmp.complete()
            end
        end

        local select_prev = function()
            if cmp.visible() then
                cmp.select_prev_item({ behavior = types.cmp.SelectBehavior.Select })
            else
                cmp.setup({ sources = copilot_source })
                cmp.complete()
            end
        end

        local abort = function(fallback)
            if cmp.visible() then
                cmp.abort()
                cmp.core:reset() -- https://github.com/hrsh7th/nvim-cmp/issues/1251#issuecomment-1365229958
            else
                fallback()
            end
        end

        local scroll_docs_up = function(fallback)
            if cmp.visible_docs() then
                cmp.scroll_docs(-4)
            else
                fallback()
            end
        end

        local scroll_docs_down = function(fallback)
            if cmp.visible_docs() then
                cmp.scroll_docs(4)
            else
                fallback()
            end
        end

        local confirm = function(fallback)
            if cmp.visible() then
                cmp.confirm({ select = false })
            else
                fallback()
            end
        end

        local cmd_history_next = function(fallback)
            if cmp.visible() then
                cmp.select_next_item({ behavior = types.cmp.SelectBehavior.Select })
            else
                fallback()
            end
        end

        local cmd_history_prev = function(fallback)
            if cmp.visible() then
                cmp.select_prev_item({ behavior = types.cmp.SelectBehavior.Select })
            else
                fallback()
            end
        end

        local utils = require("utils.lazy")
        local scrolldown = utils.floatscrolldown
        local scrollup = utils.floatscrollup

        local mapping_insert = {
            ["<C-n>"] = cmp.mapping(select_next, { "i", "s" }),
            ["<C-p>"] = cmp.mapping(select_prev, { "i", "s" }),
            [scrollup] = cmp.mapping(scroll_docs_up, { "i", "s" }),
            [scrolldown] = cmp.mapping(scroll_docs_down, { "i", "s" }),
            ["<C-l>"] = cmp.mapping(abort, { "i", "s" }),
            ["<C-e>"] = cmp.mapping(abort, { "i", "s" }),
            ["<C-y>"] = cmp.mapping(confirm, { "i", "s" }),
        }

        local mapping_cmdline = {
            ["<C-n>"] = cmp.mapping(cmd_history_next, { "c" }),
            ["<C-p>"] = cmp.mapping(cmd_history_prev, { "c" }),
            ["<Tab>"] = cmp.mapping(select_next, { "c" }),
            ["<S-Tab>"] = cmp.mapping(select_prev, { "c" }),
            ["<C-l>"] = cmp.mapping(abort, { "c" }),
            ["<C-e>"] = cmp.mapping(abort, { "c" }),
            ["<C-y>"] = cmp.mapping(confirm, { "c" }),
        }

        cmp.setup({
            completion = {
                autocomplete = false, -- `true` is invalid option
                completeopt = "menu,menuone,noinsert",
            },
            experimental = { ghost_text = true },

            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body)
                end,
            },

            mapping = mapping_insert,

            sources = normal_sources,
            window = {
                completion = cmp.config.window.bordered({ border = require("utils.lazy").floatwinborder }),
                documentation = cmp.config.window.bordered({ border = require("utils.lazy").floatwinborder }),
            },
            ---@diagnostic disable-next-line: missing-fields
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
            mapping = mapping_cmdline,
            sources = {
                { name = "buffer" },
            },
        })

        -- Use cmdline & path source for ":" (if you enabled `native_menu`, this won't work anymore).
        cmp.setup.cmdline(":", {
            completion = { autocomplete = false },
            mapping = mapping_cmdline,
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
        "saadparwaiz1/cmp_luasnip",
        { "petertriho/cmp-git",     dependencies = "nvim-lua/plenary.nvim" },
        { "zbirenbaum/copilot-cmp", event = { "LspAttach" },               opts = {}, },
        { "Gelio/cmp-natdat",       config = true },
    },
    _user_load_library = true,
}
