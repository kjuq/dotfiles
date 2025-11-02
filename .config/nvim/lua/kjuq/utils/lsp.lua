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

---@param clnt vim.lsp.Client
---@param buf integer
---@param opt table? { fix_cursor, retry }
function M.register_format_on_save(clnt, buf, opt)
	if not opt then
		opt = {}
	end
	---@return boolean success or not
	local function reg()
		if clnt:supports_method(vim.lsp.protocol.Methods.textDocument_formatting) then
			vim.api.nvim_create_autocmd('BufWritePre', {
				group = vim.api.nvim_create_augroup(string.format('kjuq_formatonsave_%s_buf_%d', clnt.name, buf), {}),
				buffer = buf,
				callback = function()
					local v ---@type vim.fn.winsaveview.ret
					if opt.fix_cursor then
						v = vim.fn.winsaveview()
					end
					vim.lsp.buf.format({ async = false, id = clnt.id })
					if opt.fix_cursor then
						vim.fn.winrestview(v)
					end
				end,
			})
			return true
		end
		return false
	end
	-- Neovim currently does not support dynamic capabilities
	-- so retry several times until dynamic registration has done
	-- https://github.com/neovim/neovim/issues/24229
	local successed = reg()
	local retrynum = opt.retry or 3
	local waitms = 1000
	if not successed then
		for i = 1, retrynum do
			vim.defer_fn(function()
				if successed then
					return
				end
				successed = reg()
			end, waitms * i)
		end
	end
end

return M
