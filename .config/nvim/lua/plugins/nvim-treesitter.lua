return {
    "nvim-treesitter/nvim-treesitter",
    event = { "VeryLazy" },
    build = function()
        require("nvim-treesitter.install").update({ with_sync = true })
    end,
    config = function ()
        require("nvim-treesitter.configs").setup {
            auto_install = true,
            highlight = { enable = true },
            indent = { enable = true },

            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = '<M-v>',
                    node_incremental = '<M-v>',
                    scope_incremental = '<M-s>',
                    node_decremental = '<M-d>',
                },
            },
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
                    keymaps = {
                        -- You can use the capture groups defined in textobjects.scm
                        ['aa'] = '@parameter.outer',
                        ['ia'] = '@parameter.inner',
                        ['af'] = '@function.outer',
                        ['if'] = '@function.inner',
                        ['ac'] = '@class.outer',
                        ['ic'] = '@class.inner',
                    },
                },
                move = {
                    enable = true,
                    set_jumps = true, -- whether to set jumps in the jumplist
                    goto_next_start = {
                        [']m'] = '@function.outer',
                        [']]'] = '@class.outer',
                    },
                    goto_next_end = {
                        [']M'] = '@function.outer',
                        [']['] = '@class.outer',
                    },
                    goto_previous_start = {
                        ['[m'] = '@function.outer',
                        ['[['] = '@class.outer',
                    },
                    goto_previous_end = {
                        ['[M'] = '@function.outer',
                        ['[]'] = '@class.outer',
                    },
                },
                swap = {
                    enable = true,
                    swap_next = {
                        ['<leader>a'] = '@parameter.inner',
                    },
                    swap_previous = {
                        ['<leader>A'] = '@parameter.inner',
                    },
                },
            },
        }
    end,
    dependencies = {
        'nvim-treesitter/nvim-treesitter-textobjects',
    },
}


