local M = {}

M.setup = function()
	local lspconfig = require("lspconfig")
	local common_opts = {
		handlers = require("core.lsp").handlers,
		-- capabilities = require("core.lsp").capabilities,
	}
	local python_path = os.getenv("HOMEBREW_PREFIX") .. "/bin/python3"
	lspconfig.pylsp.setup(vim.tbl_deep_extend("error", common_opts, {
		settings = {
			pylsp = {
				plugins = {
					jedi = {
						environment = python_path,
					},
				},
			},
		},
	}))
end

return M
