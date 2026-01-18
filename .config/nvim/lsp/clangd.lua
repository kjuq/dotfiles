-- DON'T install `clang-format` separately

-- Create ~/.clang-format during formatting
vim.api.nvim_create_autocmd({ 'LspAttach' }, {
	group = vim.api.nvim_create_augroup('kjuq_lspattach_clangd', {}),
	callback = function(parentargs)
		local client = assert(vim.lsp.get_client_by_id(parentargs.data.client_id))
		if client.name ~= 'clangd' then
			return
		end
		local bufnr = parentargs.buf
		vim.api.nvim_create_autocmd({ 'LspRequest' }, {
			group = vim.api.nvim_create_augroup('kjuq_clangd_tab_indent', {}),
			callback = function(args)
				local method = args.data.request.method
				local type = args.data.request.type
				local filepath = os.getenv('HOME') .. '/.clang-format'
				if method == 'textDocument/formatting' and type == 'pending' then
					local file = io.open(filepath, 'w')
					if file then
						file:write(table.concat({
							'IndentWidth: 4',
							'UseTab: ForIndentation',
							'TabWidth: 4',
							'ColumnLimit: 120',
						}, '\n'))
						file:close()
					else
						vim.notify('Failed to create ~/.clang-format', vim.log.levels.ERROR)
					end
				end
				if method == 'textDocument/formatting' and type == 'complete' then
					local file = io.open(filepath, 'r')
					if file then
						file:close()
						os.remove(filepath)
					end
				end
			end,
			buffer = bufnr,
		})
	end,
})

---@type vim.lsp.Config
return {}
