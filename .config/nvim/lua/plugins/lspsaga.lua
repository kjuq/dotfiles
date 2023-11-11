local map = require("utils.lazy").generate_cmd_map("", "LspSaga: ")

return {
    "nvimdev/lspsaga.nvim",
    event = { "LspAttach" },
    keys = {
        map("<leader>lci", "n", "Lspsaga incoming_calls", "[i]ncoming [c]alls"),
        map("<leader>lco", "n", "Lspsaga outgoing_calls", "[o]utgoing [c]alls"),
        map("<leader>la", { "n", "v" }, "Lspsaga code_action", "Code [a]ction"),
        map("gy", "n", "Lspsaga finder def+ref+imp+tyd", "Find def, ref, imp, and type def"),
        map("gd", "n", "Lspsaga goto_definition", "[g]o to [d]efinition"),
        map("<leader>lz", "n", "Lspsaga outline", "Show outline"),
    },
    config = function()
        require("lspsaga").setup({
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
        })
    end,
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons"
    }
}
