local map = require("utils.lazy").generate_cmd_map("", "LspSaga: ")

return {
    "nvimdev/lspsaga.nvim",
    keys = {
        map("<M-i>", "n", "Lspsaga incoming_calls", "Incoming calls"),
        map("<M-o>", "n", "Lspsaga outgoing_calls", "Outgoing calls"),
        map("gD", "n", "Lspsaga finder def+ref+imp+tyd", "Finder"),
        -- map("<M-f>", { "n", "v" }, "Lspsaga code_action", "Code action"),
        -- map("gd", "n", "Lspsaga goto_definition", "Definition"),
        -- map("K", "n", "Lspsaga hover_doc", "Hover doc"),
    },
    opts = {
        breadcrumbs = { enabled = false },
        callhierarchy = { keys = { quit = { "q", "<Esc>" } } },
        code_action = { keys = { quit = { "q", "<Esc>" } } },
        definition = { keys = { quit = { "q", "<Esc>" } } },
        diagnostic = { max_height = 0.8, keys = { quit = { "q", "<Esc>" } } },
        finder = { max_height = 0.6, keys = { toggle_or_open = { "o", "<CR>" }, quit = { "q", "<ESC>" } } },
        lightbulb = { enable = false, },
        rename = { in_select = true, keys = { quit = { "q", "<Esc>" } } },
        outline = {
            win_width = 45,
            auto_preview = false,
            detail = true,
            keys = {
                toggle_or_jump = { "o", "<CR>" },
                quit = { "q", "<Esc>" },
            }
        },
        scroll_preview = {
            scroll_down = "<C-d>",
            scroll_up = "<C-u>",
        },
    },
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons"
    }
}
