return {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    commit = "0dca9284bce128e60da18693d92999968d6cb523",
    event = { "VeryLazy" },
    config = function()
        -- disable builtin indentline
        vim.opt_local.listchars:remove("leadmultispace")
        vim.api.nvim_clear_autocmds({ group = "init_indent_line" })
        vim.api.nvim_clear_autocmds({ group = "update_indent_line" })

        local highlight = {
            "IndentBlanklineIndent1",
            "IndentBlanklineIndent2",
            "IndentBlanklineIndent3",
            "IndentBlanklineIndent4",
            "IndentBlanklineIndent5",
            "IndentBlanklineIndent6",
        }

        local hooks = require("ibl.hooks")
        hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
            vim.api.nvim_set_hl(0, "IndentBlanklineIndent1", { fg = "#E06C75", nocombine = true })
            vim.api.nvim_set_hl(0, "IndentBlanklineIndent2", { fg = "#E5C07B", nocombine = true })
            vim.api.nvim_set_hl(0, "IndentBlanklineIndent3", { fg = "#98C379", nocombine = true })
            vim.api.nvim_set_hl(0, "IndentBlanklineIndent4", { fg = "#56B6C2", nocombine = true })
            vim.api.nvim_set_hl(0, "IndentBlanklineIndent5", { fg = "#61AFEF", nocombine = true })
            vim.api.nvim_set_hl(0, "IndentBlanklineIndent6", { fg = "#C678DD", nocombine = true })
        end)

        local ibl = require("ibl")
        ibl.setup({
            indent = {
                highlight = highlight,
                char = "╎", -- "╎", "┆","│", "▏",
                tab_char = "│",
            },
            scope = { enabled = false },
        })

        ibl.refresh_all()
    end,
}
