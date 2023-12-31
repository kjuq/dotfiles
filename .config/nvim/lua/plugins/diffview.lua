local map = require("utils.lazy").generate_cmd_map("<leader>g", "Diffview: ")

return {
    "sindrets/diffview.nvim",
    cmd = {
        "DiffviewOpen",
        "DiffviewFileHistory",
        "DiffviewClose",
        "DiffviewFocusFiles",
        "DiffviewToggleFiles",
        "DiffviewRefresh",
        "DiffviewLog",
    },
    keys = {
        map("l", "n", "DiffviewFileHistory %", "File History")
    },
    config = function()
        vim.api.nvim_create_autocmd({ "FileType" }, {
            pattern = { "DiffviewFileHistory" },
            group = vim.api.nvim_create_augroup("user_diff_view", {}),
            callback = function()
                vim.keymap.set("n", "<leader>q", function() vim.cmd("DiffviewClose") end, { buffer = true })
            end,
        })
    end,
}
