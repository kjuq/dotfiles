vim.api.nvim_create_autocmd({ 'LspAttach' }, {
	group = vim.api.nvim_create_augroup('kjuq_lspattach_ruff', {}),
	callback = function(args)
		local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
		if client.name ~= 'ruff' then
			return
		end
		client.server_capabilities.hoverProvider = false
		vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
			group = vim.api.nvim_create_augroup('kjuq_ruff_codeaction_onsave', {}),
			callback = function()
				require('kjuq.utils.codeactions-on-save').apply_codeaction(client, 'source.fixAll.ruff', args.buf)
			end,
		})
	end,
})

---@type vim.lsp.Config
return {
	init_options = {
		settings = {
			lint = {
				ignore = { 'E741' },
			},
		},
	},
}
