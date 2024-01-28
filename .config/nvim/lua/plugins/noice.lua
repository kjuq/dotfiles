local map_base = require("utils.lazy").generate_map("", "")
local map = function(suffix, mode, func, comment)
    local result = map_base(suffix, mode, func, comment)
    result.silent = true
    result.expr = true
    return result
end
local cmap = require("utils.lazy").generate_cmd_map("<leader>", "Telescope: ")

return {
    "folke/noice.nvim",
    event = require("utils.lazy").verylazy,
    cmd = { "Noice" },
    keys = {
        cmap("fa", "n", "Noice telescope", "Noice"),
        map("<C-f>", "i", function() if not require("noice.lsp").scroll(4) then return "<C-f>" end end, "Page down"),
        map("<C-b>", "i", function() if not require("noice.lsp").scroll(-4) then return "<C-b>" end end, "Page up"),
    },
    opts = function()
        require("utils.lazy").quit_with_esc({ "noice" })
        return {
            cmdline = {
                format = {
                    lua = false,
                    help = false,
                },
                opts = {
                    border = { style = require("utils.lazy").floatwinborder },
                },
            },
            lsp = {
                -- progress = { enabled = false },
                -- hover = { enabled = false },
                signature = {
                    -- enabled = false,
                    auto_open = { enabled = false },
                },
                documentation = {
                    opts = {
                        border = require("utils.lazy").floatwinborder,
                        position = { row = 2, col = 2 },
                        -- size = { max_width = 70, max_height = 20, },
                    },
                },
                -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true,
                },
            },
        }
    end,
    dependencies = {
        "MunifTanjim/nui.nvim",
    },
}
