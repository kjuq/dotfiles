local map = require("utils.lazy").generate_cmd_map("<leader>", "Vim-Startuptime: ")

return {
    "dstein64/vim-startuptime",
    cmd = { "StartupTime" },
    keys = {
        map("av", "n", "StartupTime", "Calculate startup time")
    },
    config = function()
        vim.g.startuptime_tries = 10
    end,
}
