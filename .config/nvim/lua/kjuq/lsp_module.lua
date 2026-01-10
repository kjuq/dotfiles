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

---@param selected_index integer
---@param result table
---@param client vim.lsp.Client
-- https://github.com/konradmalik/neovim-flake/blob/644fe3df84dc3cf51a7d5ab2df29817ff7d6100d/config/nvim/lua/pde/lsp/capabilities/textDocument_completion.lua
local function show_documentation(selected_index, result, client)
	local docs = vim.tbl_get(result, 'documentation', 'value')
	if not docs then
		return
	end

	local wininfo = vim.api.nvim__complete_set(selected_index, { info = docs .. '\n\n_client: ' .. client.name .. '_' })
	if vim.tbl_isempty(wininfo) or not vim.api.nvim_win_is_valid(wininfo.winid) then
		return
	end

	vim.wo[wininfo.winid].conceallevel = 2
	vim.wo[wininfo.winid].concealcursor = 'n'

	if not vim.api.nvim_buf_is_valid(wininfo.bufnr) then
		return
	end

	vim.bo[wininfo.bufnr].syntax = 'markdown'
	vim.treesitter.start(wininfo.bufnr, 'markdown')
end

local documentation_is_enabled = true
---@param client vim.lsp.Client
---@param bufnr integer
function M.register_completion_documentation(client, bufnr)
	if not client:supports_method(vim.lsp.protocol.Methods.completionItem_resolve) then
		return
	end

	local _, cancel_prev = nil, function() end

	vim.api.nvim_create_autocmd('CompleteChanged', {
		group = vim.api.nvim_create_augroup(
			string.format('kjuq_completion_documentation_%s_buf_%d', client.name, bufnr),
			{}
		),
		buffer = bufnr,
		callback = function()
			cancel_prev()
			if not documentation_is_enabled then
				return
			end

			local completion_item = vim.tbl_get(vim.v.completed_item, 'user_data', 'nvim', 'lsp', 'completion_item')
			if not completion_item then
				return
			end

			local complete_info = vim.fn.complete_info({ 'selected' })
			if vim.tbl_isempty(complete_info) then
				return
			end

			local selected_index = complete_info.selected

			_, cancel_prev = vim.lsp.buf_request(
				bufnr,
				vim.lsp.protocol.Methods.completionItem_resolve,
				completion_item,
				function(err, item)
					if err ~= nil then
						-- vim.notify(
						-- 	'Error from client ' .. client.name .. ' when getting documentation\n' .. vim.inspect(err),
						-- 	vim.log.levels.WARN
						-- )
						-- at this stage just disable it
						documentation_is_enabled = false
						return
					end
					if not item then
						return
					end
					show_documentation(selected_index, item, client)
				end
			)
		end,
	})
end

---@param client vim.lsp.Client
---@param bufnr integer
function M.register_inlinecompletion(client, bufnr)
	vim.keymap.set('i', '<C-a>', vim.lsp.inline_completion.get, { desc = 'Get the current inline completion' })
	if client:supports_method('textDocument/inlineCompletion') then
		-- https://github.com/neovim/nvim-lspconfig/pull/4029
		-- To sign-in `:LspCopilotSignIn`
		vim.keymap.set('n', '<Space>ti', function()
			vim.lsp.inline_completion.enable(true, { bufnr = bufnr })
		end, { buffer = bufnr, desc = 'Enable inline completion' })
		vim.keymap.set('n', '<Space>tI', function()
			vim.lsp.inline_completion.enable(false, { bufnr = bufnr })
		end, { buffer = bufnr, desc = 'Disable inline completion' })
	end
end

return M
