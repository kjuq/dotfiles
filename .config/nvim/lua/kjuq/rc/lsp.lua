vim.diagnostic.config({
	signs = false,
	float = {
		max_width = 80,
		max_height = 20,
		header = '',
		format = function(diagnostic)
			return string.format('%s\n⊳ %s', diagnostic.message, diagnostic.source)
		end,
	},
	jump = {
		float = true,
	},
})

vim.lsp.enable('snippet')

---@param ev table ref. `help event-args`
local on_attach = function(ev)
	local bufnr = ev.buf

	-- Buffer-local keymaps
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'LSP: Go to definition', buffer = bufnr })
	vim.keymap.set(
		'n',
		'grQ',
		vim.lsp.buf.workspace_diagnostics,
		{ desc = 'LSP: Workspace diagnostics', buffer = bufnr }
	)
	local vl_enabled = false
	vim.keymap.set('n', '<M-l>', function()
		vim.diagnostic.config({
			virtual_lines = not vl_enabled and { current_line = true } or false,
		})
		vl_enabled = not vl_enabled
		-- TODO: disable when cursor moved beyond lines
	end, { desc = 'LSP: Toggle virtual lines of diagnostic' })

	local client_id = ev.data.client_id
	local client = assert(vim.lsp.get_client_by_id(client_id))

	require('kjuq.utils.lsp').register_format_on_save(client, bufnr, {
		fix_cursor = vim.tbl_contains({ 'efm' }, client.name),
	})
	require('kjuq.utils.lsp').register_autocompletion(client, bufnr, false)
	require('kjuq.utils.lsp').register_inlinecompletion(client, bufnr)
end

vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('kjuq_user_lsp_config', {}),
	callback = on_attach,
})
