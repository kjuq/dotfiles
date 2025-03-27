local M = {}

M.float_max_width = 80
M.float_max_height = 20

M.hover_opts = { -- currently not used
	-- title = ' Lsp: Hover ',
	border = vim.o.winborder,
	max_width = M.float_max_width,
	max_height = M.float_max_height,
}

M.diagnostic_opts = {
	signs = false,
	float = {
		max_width = M.float_max_width,
		max_height = M.float_max_height,
		header = false,
		format = function(diagnostic)
			return string.format('%s\n⊳ %s', diagnostic.message, diagnostic.source)
		end,
	},
}

---@param ev table ref. `help event-args`
local on_attach = function(ev)
	local bufnr = ev.buf

	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'LSP: Go to definition', buffer = bufnr })

	local vl_enabled = false
	vim.keymap.set('n', '<M-l>', function()
		vim.diagnostic.config({
			virtual_lines = not vl_enabled and { current_line = true } or false,
		})
		vl_enabled = not vl_enabled
		-- TODO: disable when cursor moved beyond lines
	end, { desc = 'LSP: Toggle virtual lines of diagnostic' })

	-- Format on save
	local client_id = ev.data.client_id
	local client = vim.lsp.get_client_by_id(client_id)
	if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_formatting) then
		vim.api.nvim_create_autocmd('BufWritePre', {
			group = vim.api.nvim_create_augroup('kjuq_formatonsave_lsp', { clear = false }),
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.format({ async = false, id = client_id })
			end,
		})
	end

	-- -- Built-in auto completion
	-- if client and client:supports_method('textDocument/completion') then
	-- 	vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
	-- end
end

M.setup = function()
	vim.diagnostic.config(M.diagnostic_opts)
	vim.api.nvim_create_autocmd('LspAttach', {
		group = vim.api.nvim_create_augroup('kjuq_user_lsp_config', {}),
		callback = on_attach,
	})
end

return M
