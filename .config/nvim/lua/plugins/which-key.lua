local map = require("utils.lazy").generate_cmd_map("<leader>", "Which-key: ")

local active = false
local toggle = function()
    if active then
        print("Which-key is inactive")
        vim.o.timeout = false
    else
        print("Which-key is active")
        vim.o.timeout = true
        vim.o.timeoutlen = 500
    end
    active = not active
end

return {
    "folke/which-key.nvim",
    keys = {
        { "<leader>aw", mode = { "n" }, toggle, desc = "Which-key: Toggle" },
        map("pw", "n", "WhichKey", "[p]ick all mappings ([w]hich)"),
    },
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
            window = {
                border = "single",
            },
            layout = {
                width = { max = 80 }, -- min and max width of the columns
                spacing = 3,          -- spacing between columns
                align = "left",       -- align columns left, center or right
            },
        }
    end,
}
