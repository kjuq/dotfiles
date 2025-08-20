local M = {}

local loaded_clients = {}
function M.workspace_didopen()
	-- https://github.com/artemave/workspace-diagnostics.nvim
	-- https://artem.rocks/posts/workspace_diagnostics_nvim
	for _, client in ipairs(vim.lsp.get_clients()) do
		if vim.tbl_contains(loaded_clients, client.id) then
			return
		end
		table.insert(loaded_clients, client.id)
		if not vim.tbl_get(client.server_capabilities, 'textDocumentSync', 'openClose') then
			return
		end
		local exclude = {
			[[/.git/]],
			[[/.git$]],
			[[/node_modules/]],
		}
		local workspace_files
		for _, workspace_folder in ipairs(vim.lsp.buf.list_workspace_folders()) do
			workspace_files = vim.fs.find(function(_, path)
				for _, ignore in ipairs(exclude) do
					if path:match(ignore) then
						return false
					end
				end
				return true
			end, { limit = math.huge, type = 'file', path = workspace_folder })
		end
		for _, path in ipairs(workspace_files) do
			-- Skip current buffer
			if path == vim.api.nvim_buf_get_name(0) then
				goto continue
			end
			local filetype = vim.filetype.match({ filename = path })
			---@diagnostic disable-next-line: undefined-field
			local clientft = client.config.filetypes
			if not clientft or not vim.tbl_contains(clientft, filetype) then
				goto continue
			end
			local params = {
				textDocument = {
					uri = vim.uri_from_fname(path),
					version = 0,
					text = vim.fn.join(vim.fn.readfile(path), '\n'),
					languageId = filetype,
				},
			}
			client:notify(vim.lsp.protocol.Methods.textDocument_didOpen, params)
			::continue::
		end
	end
end

return M
