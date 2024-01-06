local success, capabilities = pcall(function() require("cmp_nvim_lsp").default_capabilities() end)
if not success then
    capabilities = nil
end

local handlers = { -- this is now disabled to use noice-hover-scroll
    ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        title = " Lsp: Hover ",
        border = require("utils.lazy").floatwinborder,
        max_width = 80,
        max_height = 20,
    }),
    ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
        title = " Lsp: Signature Help ",
        border = require("utils.lazy").floatwinborder,
        max_width = 80,
        max_height = 20,
    }),
}

return {
    capabilities = capabilities,
    _handlers = handlers, -- enable noice's lsp window
}
