local M = {}

M.opts = {
	on_attach = function(client, _)
		client.server_capabilities.hoverProvider = false
		vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
			group = vim.api.nvim_create_augroup('kjuq_ruff_codeaction_onsave', {}),
			callback = function()
				vim.lsp.buf.code_action({
					context = {
						diagnostics = {},
						only = { 'source.fixAll' },
					},
					filter = function(action)
						if action.kind and action.kind == 'source.fixAll.ruff' then
							return true
						end
						return false
					end,
					apply = true,
				})
			end,
		})
	end,
}

return M
