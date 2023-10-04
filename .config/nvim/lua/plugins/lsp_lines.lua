return {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    event = { "LspAttach" },
    keys = {
        {
            "<leader>Ll",
            mode = { "n" },
            function () require("lsp_lines").toggle() end,
            "Toggle lsp_lines",
        }
    },
    opts = function ()
        vim.diagnostic.config({
            virtual_text = false,
            virtual_lines = {
                only_current_line = true,
                highlight_whole_line = false,
            },
        })
        return {}
    end
}


