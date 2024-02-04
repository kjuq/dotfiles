local M = {}

M.setup = function()
	local common_opts = require("plugins.lsp.common")
	local lspconfig = require("lspconfig")
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
