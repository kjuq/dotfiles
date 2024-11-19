-- local ok, cmp_lsp = pcall(require, 'cmp_nvim_lsp')
-- local capabilities = ok and cmp_lsp.default_capabilities() or {}
local capabilities = {
	workspace = {
		didChangeWatchedFiles = {
			dynamicRegistration = true,
		},
	},
}

local M = {}

M.opts = {
	capabilities = capabilities,
}

return M
