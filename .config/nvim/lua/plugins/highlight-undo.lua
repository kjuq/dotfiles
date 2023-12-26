-- This plugin may be incompatible with nvim-cmp
-- See: https://github.com/tzachar/highlight-undo.nvim/issues/2

return {
    "tzachar/highlight-undo.nvim",
    lazy = false,
    opts = {
        duration = 125,
        undo = {
            hlgroup = "HighlightUndo",
            mode = "n",
            lhs = "u",
            map = "undo",
            opts = {}
        },
        redo = {
            hlgroup = "HighlightUndo",
            mode = "n",
            lhs = "<C-r>",
            map = "redo",
            opts = {}
        },
        highlight_for_count = true,
    },
}
