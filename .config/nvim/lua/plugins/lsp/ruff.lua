local M = {}

M.opts = {
	on_attach = function(client, _)
		client.server_capabilities.hoverProvider = false
	end,
}

return M
