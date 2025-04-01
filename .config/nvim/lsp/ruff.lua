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

local on_attach = function(client, _)
	client.server_capabilities.hoverProvider = false
	vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
		group = vim.api.nvim_create_augroup('kjuq_ruff_codeaction_onsave', {}),
		callback = callback,
	})
end

return {
	cmd = { 'ruff', 'server' },
	filetypes = { 'python' },
	root_markers = { 'pyproject.toml', 'ruff.toml', '.ruff.toml' },
	single_file_support = true,
	init_options = {
		settings = {
			lint = {
				ignore = { 'E741' },
			},
		},
	},
	on_attach = on_attach,
}
