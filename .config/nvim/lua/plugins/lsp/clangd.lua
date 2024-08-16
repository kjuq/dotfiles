local M = {}

M.opts = {
	on_attach = function(client, _)
		-- Disable format capability
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.documentOnTypeFormattingProvider = false
		client.server_capabilities.documentRangeFormattingProvider = false
	end,
}

return M
