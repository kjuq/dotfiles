return {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    event = { "LspAttach" },
    enabled = false,
    config = function ()
        vim.diagnostic.config({
            virtual_text = false,
            virtual_lines = {
                only_current_line = true,
                highlight_whole_line = false,
            },
        })
        require("lsp_lines").setup()
    end
}


