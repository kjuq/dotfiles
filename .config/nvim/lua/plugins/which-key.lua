local map = require("utils.lazy").generate_cmd_map("<leader>", "Which-key: ")

local active = false

local enable = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 700
    active = true
end

local disable = function()
    vim.o.timeout = false
    active = false
end

local toggle = function()
    if active then
        print("Which-key is inactive")
        disable()
    else
        print("Which-key is active")
        enable()
    end
end

return {
    "folke/which-key.nvim",
    event = require("utils.lazy").verylazy,
    keys = {
        { "<leader>aw", mode = { "n" }, toggle,                             desc = "Which-key: Toggle" },
        { "<leader>aW", mode = { "n" }, function() vim.cmd("WhichKey") end, desc = "Which-key: Show" },
    },
    opts = function()
        enable()

        require("which-key").register({
            ["<leader>a"] = { name = "Additional", _ = "which_key_ignore" },
            ["<leader>c"] = { name = "ChatGPT", _ = "which_key_ignore" },
            ["<leader>d"] = { name = "Debug", _ = "which_key_ignore" },
            ["<leader>f"] = { name = "Find", _ = "which_key_ignore" },
            ["<leader>g"] = { name = "Git", _ = "which_key_ignore" },
            ["<leader>p"] = { name = "Pick", _ = "which_key_ignore" },
            ["<leader>r"] = { name = "Re {name, sume}", _ = "which_key_ignore" },
            ["<leader>t"] = { name = "LSP", _ = "which_key_ignore", c = "[c]all", w = "[w]orkspace" },
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
