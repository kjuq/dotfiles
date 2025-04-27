vim.api.nvim_create_autocmd({ 'LspAttach' }, {
	group = vim.api.nvim_create_augroup('kjuq_lspattach_clangd', {}),
	callback = function(args)
		local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
		if client.name ~= 'clangd' then
			return
		end
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.documentRangeFormattingProvider = false
		client.server_capabilities.documentOnTypeFormattingProvider = nil
	end,
})

return {}
