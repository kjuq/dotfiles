local map = require("utils.lazy").generate_cmd_map("<leader>c", "ChatGPT")

return {
    "jackMort/ChatGPT.nvim",
    cmd = { "ChatGPT", "ChatGPTActAs", "ChatGPTEditWithInstructions", "ChatGPTRun", },
    keys = {
        map("c", { "n" }, "ChatGPT", ": Open ChatGPT"),
        map("e", { "n", "v" }, "ChatGPTEditWithInstruction", ": Edit with instruction"),
        map("g", { "n", "v" }, "ChatGPTRun grammar_correction", ".Run: Grammar Correction"),
        map("t", { "n", "v" }, "ChatGPTRun translate", ".Run: Translate"),
        map("k", { "n", "v" }, "ChatGPTRun keywords", ".Run: Keywords"),
        map("d", { "n", "v" }, "ChatGPTRun docstring", ".Run: Docstring"),
        map("a", { "n", "v" }, "ChatGPTRun add_tests", ".Run: Add Tests"),
        map("o", { "n", "v" }, "ChatGPTRun optimize_code", ".Run: Optimize Code"),
        map("s", { "n", "v" }, "ChatGPTRun summarize", ".Run: Summarize"),
        map("f", { "n", "v" }, "ChatGPTRun fix_bugs", ".Run: Fix Bugs"),
        map("x", { "n", "v" }, "ChatGPTRun explain_code", ".Run: Explain Code"),
        map("r", { "n", "v" }, "ChatGPTRun roxygen_edit", ".Run: Roxygen Edit"),
        map("l", { "n", "v" }, "ChatGPTRun code_readability_analysis", ".Run: Code Readability Analysis"),
    },
    opts = {
        api_key_cmd = 'pass openai.com/api_key',
        yank_register = "+",
        edit_with_instructions = {
            keymaps = {
                close = "<Esc>",
                -- accept = "<C-y>",
                -- toggle_diff = "<C-d>",
                -- toggle_settings = "<C-o>",
                -- cycle_windows = "<Tab>",
                -- use_output_as_input = "<C-i>",
            },
        },
        chat = {
            keymaps = {
                close = { "<Esc>" },
                -- yank_last = "<C-y>",
                -- yank_last_code = "<C-k>",
                -- scroll_up = "<C-u>",
                -- scroll_down = "<C-d>",
                -- new_session = "<C-n>",
                -- cycle_windows = "<Tab>",
                -- cycle_modes = "<C-f>",
                -- next_message = "<C-j>",
                -- prev_message = "<C-k>",
                -- select_session = "<Space>",
                -- rename_session = "r",
                -- delete_session = "d",
                -- draft_message = "<C-d>",
                -- edit_message = "e",
                -- delete_message = "d",
                -- toggle_settings = "<C-o>",
                -- toggle_message_role = "<C-r>",
                -- toggle_system_role_open = "<C-s>",
                -- stop_generating = "<C-x>",
            },
        },
        popup_input = {
            submit = "<Enter>",
            -- submit_n = "<Enter>",
            -- max_visible_lines = 20,
        },
    },
    dependencies = {
        "MunifTanjim/nui.nvim",
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim"
    }
}
