local map_base = require("utils.lazy").generate_map("", "")
local map = function(suffix, mode, func, comment)
    local result = map_base(suffix, mode, func, comment)
    result.silent = true
    result.expr = true
    return result
end
local cmap = require("utils.lazy").generate_cmd_map("<leader>", "Telescope.extensions: ")

return {
    "folke/noice.nvim",
    event = { "CursorMoved", "ModeChanged" },
    cmd = {
        "Noice",
        "NoiceLog",
        "NoiceLast",
        "NoiceDebug",
        "NoiceStats",
        "NoiceConfig",
        "NoiceEnable",
        "NoiceErrors",
        "NoiceRoutes",
        "NoiceDisable",
        "NoiceDismiss",
        "NoiceHistory",
        "NoiceTelescope",
        "NoiceViewstats",
    },
    keys = {
        cmap("fn", "n", "Noice telescope", "Pick noice"),
        map("<C-d>", "i", function() if not require("noice.lsp").scroll(4) then return "<C-d>" end end, "Half down"),
        map("<C-u>", "i", function() if not require("noice.lsp").scroll(-4) then return "<C-u>" end end, "Half up"),
    },
    opts = function()
        require("utils.common").quit_with_esc({ "noice" })
        return {
            lsp = {
                signature = { auto_open = { enabled = false } },
                documentation = {
                    opts = {
                        border = "rounded",
                        position = { row = 2, col = 2 },
                        size = { max_width = 80, max_height = 20, },
                    },
                },
                -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true,
                },
            },
            presets = {
                command_palette = false,      -- position the cmdline and popupmenu together
                long_message_to_split = true, -- long messages will be sent to a split
            },
        }
    end,
    dependencies = {
        "MunifTanjim/nui.nvim",
    },
}
