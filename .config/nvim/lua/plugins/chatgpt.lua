local map = require("utils.lazy").generate_cmd_map("<leader>c", "ChatGPT: ")

return {
    "jackMort/ChatGPT.nvim",
    cmd = { "ChatGPT", "ChatGPTActAs", "ChatGPTEditWithInstructions", "ChatGPTRun", },
    keys = {
        map("c", { "n" }, "ChatGPT", "Open ChatGPT"),
        map("e", { "n", "v" }, "ChatGPTEditWithInstruction", "Edit with instruction"),
        map("g", { "n", "v" }, "ChatGPTRun grammar_correction", "Grammar Correction"),
        map("t", { "n", "v" }, "ChatGPTRun translate", "Translate"),
        map("k", { "n", "v" }, "ChatGPTRun keywords", "Keywords"),
        map("d", { "n", "v" }, "ChatGPTRun docstring", "Docstring"),
        map("a", { "n", "v" }, "ChatGPTRun add_tests", "Add Tests"),
        map("o", { "n", "v" }, "ChatGPTRun optimize_code", "Optimize Code"),
        map("s", { "n", "v" }, "ChatGPTRun summarize", "Summarize"),
        map("f", { "n", "v" }, "ChatGPTRun fix_bugs", "Fix Bugs"),
        map("x", { "n", "v" }, "ChatGPTRun explain_code", "Explain Code"),
        map("r", { "n", "v" }, "ChatGPTRun roxygen_edit", "Roxygen Edit"),
        map("l", { "n", "v" }, "ChatGPTRun code_readability_analysis", "Code Readability Analysis"),
    },
    opts = {
        api_key_cmd = "pass openai.com/api_key",
        yank_register = "+",
        chat = {
            keymaps = {
                scroll_down = "<C-d>",
                draft_message = "<M-d>",
            },
        },
        popup_input = {
            submit = "<Enter>",
        },
        openai_params = {
            -- model = "gpt-3.5-turbo",
            max_tokens = 3000, -- https://github.com/jackMort/ChatGPT.nvim/issues/302
        },
    },
    dependencies = {
        "MunifTanjim/nui.nvim",
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim"
    }
}
