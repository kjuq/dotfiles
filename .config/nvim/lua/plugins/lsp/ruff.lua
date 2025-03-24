local M = {}

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

M.opts = {
	on_attach = function(client, _)
		client.server_capabilities.hoverProvider = false
		vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
			group = vim.api.nvim_create_augroup('kjuq_ruff_codeaction_onsave', {}),
			callback = callback,
		})
	end,
	-- https://docs.astral.sh/ruff/editors/settings
	init_options = {
		settings = {
			lint = {
				ignore = { 'E741' },
			},
		},
	},
}

return M
