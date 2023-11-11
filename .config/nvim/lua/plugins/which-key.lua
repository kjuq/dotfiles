local map = require("utils.lazy").generate_cmd_map("<leader>", "Which-key: ")

return {
    "folke/which-key.nvim",
    event = { "BufNewFile", "BufReadPost" },
    keys = {
        { "<leader>", mode = "n" },
        map("pw", "n", "WhichKey", "[p]ick all mappings ([w]hich)"),
    },
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
    end,
    opts = function()
        require("which-key").register({
            ["<leader>a"] = { name = "[a]dditional", _ = "which_key_ignore" },
            ["<leader>c"] = { name = "[c]hatGPT", _ = "which_key_ignore" },
            ["<leader>d"] = { name = "[d]ebug", _ = "which_key_ignore" },
            ["<leader>f"] = { name = "[f]ind", _ = "which_key_ignore" },
            ["<leader>g"] = { name = "[g]it", _ = "which_key_ignore" },
            ["<leader>h"] = { name = "[h]istory", _ = "which_key_ignore" },
            ["<leader>l"] = { name = "[l]SP", _ = "which_key_ignore", c = "[c]all" },
            ["<leader>p"] = { name = "[p]ick", _ = "which_key_ignore" },
            ["<leader>r"] = { name = "[r]ename or [r]esume", _ = "which_key_ignore" },
            ["<leader>s"] = { name = "[s]earch", _ = "which_key_ignore" },
            ["<leader>t"] = { name = "[t]ree", _ = "which_key_ignore" },
            -- ["<leader>w"] = { name = "[w]orkspace", _ = "which_key_ignore" },
        })

        return {
            layout = {
                width = { max = 80 }, -- min and max width of the columns
                spacing = 3,          -- spacing between columns
                align = "left",       -- align columns left, center or right
            },
        }
    end,
}
