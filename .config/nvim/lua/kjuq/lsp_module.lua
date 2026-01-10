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

-- https://github.com/fnune/codeactions-on-save.nvim
-- https://github.com/fnune/codeactions-on-save.nvim/blob/1445e1ab60f64f62ff7765cd6537333f636ca29b/lua/codeactions-on-save/main.lua

---@alias ActionKind string Code action kinds (e.g., "source.organizeImports", "source.fixAll.ruff")

---@param client vim.lsp.Client
---@param action table
---@param buf integer
---@param timeout_ms integer
---@param attempts integer
local function handle_action_sync(client, action, buf, timeout_ms, attempts)
	if attempts > 3 then
		vim.notify('Max resolve attempts reached for action ' .. action.kind, vim.log.levels.WARN)
		return
	end
	if action.edit then
		vim.lsp.util.apply_workspace_edit(action.edit, 'utf-16')
	elseif action.command then
		-- vim.lsp.buf.execute_command(action.command)
		client:exec_cmd(action.command) -- I am not sure this works or not though
	else
		-- neovim:runtime/lua/vim/lsp/buf.lua shows how to run a code action
		-- synchronously. This section is based on that.
		local resolve_result = vim.lsp.buf_request_sync(buf, 'codeAction/resolve', action, timeout_ms)
		if resolve_result then
			for _, resolved_action in pairs(resolve_result) do
				handle_action_sync(client, resolved_action.result, buf, timeout_ms, attempts + 1)
			end
		else
			vim.notify(
				'Failed to resolve code action ' .. action.kind .. ' without edit or command',
				vim.log.levels.WARN
			)
		end
	end
end

---@param client vim.lsp.Client
---@param kind ActionKind|ActionKind[]
---@param buf integer
---@param timeout_ms? integer
function M.apply_codeaction(client, kind, buf, timeout_ms)
	if not timeout_ms then
		timeout_ms = 1000
	end
	local params = vim.lsp.util.make_range_params(0, 'utf-16')
	params['context'] = { diagnostics = {} }
	local response = client:request_sync('textDocument/codeAction', params, timeout_ms, buf)
	if not response then
		return
	end
	if type(kind) ~= 'table' then
		kind = { kind }
	end
	for _, action in pairs(response.result or {}) do
		if vim.tbl_contains(kind, action.kind) then
			handle_action_sync(client, action, buf, timeout_ms, 0)
		end
	end
end

return M
