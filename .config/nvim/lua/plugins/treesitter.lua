return {
    "nvim-treesitter/nvim-treesitter",
    event = require("utils.lazy").verylazy,
    build = function()
        require("nvim-treesitter.install").update({ with_sync = true })
    end,
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "regex", "markdown", "markdown_inline" },
            sync_install = true,
            auto_install = true,

            highlight = {
                enable = true,
                disable = { "perl" },
            },

            indent = { enable = true },

            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<M-v>",
                    node_incremental = "<M-v>",
                    -- scope_incremental = "<M-s>",
                    node_decremental = "<M-s>", -- shrink
                },
            },

            textobjects = {
                select = {
                    enable = true,
                    lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
                    keymaps = {
                        -- You can use the capture groups defined in textobjects.scm
                        ["aa"] = "@parameter.outer",
                        ["ia"] = "@parameter.inner",
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                        ["aC"] = "@class.outer",
                        ["iC"] = "@class.inner",
                    },
                },
                move = {
                    enable = true,
                    set_jumps = true, -- whether to set jumps in the jumplist
                    goto_next_start = {
                        ["]f"] = "@function.outer",
                    },
                    goto_next_end = {
                        ["]F"] = "@function.outer",
                    },
                    goto_previous_start = {
                        ["[f"] = "@function.outer",
                    },
                    goto_previous_end = {
                        ["[F"] = "@function.outer",
                    },
                },
                swap = {
                    enable = true,
                    swap_next = {
                        ["<M-t>"] = "@parameter.inner",
                    },
                    swap_previous = {
                        ["<M-S-t>"] = "@parameter.inner",
                    },
                },
            },
        })
    end,
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
    },
}
