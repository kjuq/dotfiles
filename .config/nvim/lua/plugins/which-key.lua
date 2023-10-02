return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    keys = {
        {
            "<leader>lw",
            mode = { "n" },
            "<Cmd>WhichKey<CR>",
            desc = "Which-key: [l]ist all mappings ([w]hich)"
        },
    },
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
    end,
    opts = function ()
        require("which-key").register({
            ["<leader>c"] = { name = "[c]all or [c]ode action", _ = "which_key_ignore" },
            ["<leader>f"] = { name = "[f]ind", _ = "which_key_ignore", f = "Telescope.builtin: [f]ind [f]iles" },
            ["<leader>g"] = { name = "[g]it", _ = "which_key_ignore" },
            ["<leader>h"] = { name = "[h]istory", _ = "which_key_ignore" },
            ["<leader>l"] = { name = "[l]ist", _ = "which_key_ignore" },
            ["<leader>L"] = { name = "[L]SP", _ = "which_key_ignore", c = "[c]all" },
            ["<leader>r"] = { name = "[r]ename or [r]esume", _ = "which_key_ignore" },
            ["<leader>s"] = { name = "[s]ave session", _ = "which_key_ignore" },
            ["<leader>t"] = { name = "[t]ree", _ = "which_key_ignore" },
            ["<leader>w"] = { name = "[w]orkspace", _ = "which_key_ignore" },
        })

        return {
            layout = {
                width = { max = 80 }, -- min and max width of the columns
                spacing = 3, -- spacing between columns
                align = "left", -- align columns left, center or right
            },
        }
    end,
}

