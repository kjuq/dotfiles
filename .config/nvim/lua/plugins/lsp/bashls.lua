local M = {}

M.setup = function()
	local common_opts = {
		handlers = require("core.lsp").handlers,
		-- capabilities = require("core.lsp").capabilities,
	}
	local lspconfig = require("lspconfig")
	lspconfig.bashls.setup(vim.tbl_deep_extend("error", common_opts, {}))
end

return M
