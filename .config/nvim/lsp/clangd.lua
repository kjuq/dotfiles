vim.api.nvim_create_autocmd({ 'LspAttach' }, {
	group = vim.api.nvim_create_augroup('kjuq_lspattach_clangd', {}),
	callback = function(args)
		local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
		if client.name ~= 'clangd' then
			return
		end
		local bufnr = args.buf
		local groupname = string.format('kjuq_formatonsave_%s_buf_%d', client.name, bufnr)
		vim.schedule(function()
			vim.api.nvim_del_augroup_by_name(groupname)
		end)
	end,
})

---@type vim.lsp.Config
return {}
