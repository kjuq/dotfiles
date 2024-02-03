local M = {}

M.setup = function()
    local common_opts = require("plugins/lsp/common")
    local lspconfig = require("lspconfig")
    lspconfig.bashls.setup(vim.tbl_deep_extend("error", common_opts, {}))
end

return M
