return {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = { "BufNewFile", "BufReadPost" },
    opts = function()
        local success, cmp = pcall(require, "cmp")
        if success then
            cmp.event:on("menu_opened", function()
                vim.b.copilot_suggestion_hidden = true
            end)

            cmp.event:on("menu_closed", function()
                vim.b.copilot_suggestion_hidden = false
            end)
        end

        return {
            suggestion = {
                enabled = false,
                auto_trigger = false,
                keymap = {
                    accept = "<C-e>",
                    accept_word = "<M-f>",
                    accept_line = false,
                    next = "<C-f>",
                    prev = "<C-b>",
                    dismiss = "<C-c>",
                },
            },
            panel = {
                enabled = false,
            },
        }
    end,
}
