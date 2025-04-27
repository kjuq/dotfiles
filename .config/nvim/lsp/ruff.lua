local callback = function()
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
	-- Sync code action is not implemented yet
	-- https://github.com/neovim/neovim/issues/24168
	vim.api.nvim_create_autocmd({ 'TextChanged' }, {
		group = vim.api.nvim_create_augroup('kjuq_ruff_codeaction_completed', {}),
		callback = function()
			vim.cmd.write()
		end,
		once = true,
		buffer = 0,
	})
end

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
			callback = callback,
		})
	end,
})

return {
	init_options = {
		settings = {
			lint = {
				ignore = { 'E741' },
			},
		},
	},
}
