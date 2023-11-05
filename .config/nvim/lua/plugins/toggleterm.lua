local map = require("utils.lazy").generate_cmd_map("", "ToggleTerm: ")

return {
    "akinsho/toggleterm.nvim",
    version = "*",
    keys = {
        map("<C-space>", { "n", "i" }, "ToggleTerm", "Open floating term window")
    },
    cmd = {
        "ToggleTerm",
        "ToggleTermSetName",
        "ToggleTermToggleAll",
        "ToggleTermSendCurrentLine",
        "ToggleTermSendVisualLines",
        "ToggleTermSendVisualSelection",
    },
    opts = function()
        ---@diagnostic disable-next-line: duplicate-set-field
        function _G.set_terminal_keymaps()
            local opts = { buffer = 0 }
            vim.keymap.set("t", "<esc>", function() vim.cmd("ToggleTerm") end, opts)
        end

        vim.api.nvim_create_autocmd({ "TermOpen" }, {
            pattern = "term://*toggleterm#*",
            callback = function() set_terminal_keymaps() end,
        })

        return {
            open_mapping = "<C-space>",
            direction = "float",
            -- float_opts = { winblend = 20, },
        }
    end
}
