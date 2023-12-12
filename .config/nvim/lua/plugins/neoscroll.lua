local map = require("utils.lazy").generate_map("", "Neoscroll: ")
local nx = { "n", "x" }

local duration = 10

return {
    "karb94/neoscroll.nvim",
    keys = {
        map("<C-u>", nx, function()
            if not require("noice.lsp").scroll(-4) then
                require("neoscroll").scroll(-vim.wo.scroll, true, duration)
            end
        end, "Half up"),
        map("<C-d>", nx, function()
            if not require("noice.lsp").scroll(4) then
                require("neoscroll").scroll(vim.wo.scroll, true, duration)
            end
        end, "Half down"),
        map("<C-b>", nx, function()
            require("neoscroll").scroll(-vim.api.nvim_win_get_height(0), true, duration)
        end, "Up"),
        map("<C-f>", nx, function()
            require("neoscroll").scroll(vim.api.nvim_win_get_height(0), true, duration)
        end, "Down"),
        map("zt", nx, function() require("neoscroll").zt(duration) end, "Top this line"),
        map("zz", nx, function() require("neoscroll").zz(duration) end, "Center this line"),
        map("zb", nx, function() require("neoscroll").zb(duration) end, "Bottom this line"),
    },
    opts = {
        mappings = {},
        hide_cursor = false,
    }
}
