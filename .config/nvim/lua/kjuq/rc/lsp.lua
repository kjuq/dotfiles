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
local function enable_completion_documentation(client, bufnr)
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
						vim.notify(
							'Error from client ' .. client .. ' when getting documentation\n' .. vim.inspect(err),
							vim.log.levels.WARN
						)
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

	-- Format on save
	local client_id = ev.data.client_id
	local client = assert(vim.lsp.get_client_by_id(client_id))
	local fix_cursor = vim.tbl_contains({ 'efm' }, client.name)
	if client:supports_method(vim.lsp.protocol.Methods.textDocument_formatting) then
		vim.api.nvim_create_autocmd('BufWritePre', {
			group = vim.api.nvim_create_augroup(string.format('kjuq_formatonsave_%s_buf_%d', client.name, bufnr), {}),
			buffer = bufnr,
			callback = function()
				local v ---@type vim.fn.winsaveview.ret
				if fix_cursor then
					v = vim.fn.winsaveview()
				end
				vim.lsp.buf.format({ async = false, id = client_id })
				if fix_cursor then
					vim.fn.winrestview(v)
				end
			end,
		})
	end

	-- Built-in auto completion
	if client:supports_method(vim.lsp.protocol.Methods.textDocument_completion) then
		vim.opt.completeopt:append({ 'noselect' })
		local ascii = {}
		for i = 32, 126 do
			ascii[#ascii + 1] = string.char(i)
		end
		client.server_capabilities.completionProvider.triggerCharacters = ascii
		vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
	end

	-- Completion is triggered only on inserting new characters,
	-- if we delete char to adjust the match, popup disappears this solves it
	local function is_at_start_of_line()
		local line, col = unpack(vim.api.nvim_win_get_cursor(0))
		local current_line = vim.api.nvim_buf_get_lines(0, line - 1, line, false)[1] or ''
		local before_cursor = current_line:sub(1, col)
		return before_cursor:match('^%s*$') ~= nil
	end
	local trigger_debounce_ms = 1
	local trigger_timer = assert(vim.uv.new_timer(), 'cannot create timer')
	for _, keys in ipairs({ '<BS>', '<C-h>', '<C-w>', '<C-u>' }) do
		vim.keymap.set('i', keys, function()
			trigger_timer:stop()
			if vim.fn.pumvisible() or trigger_timer:get_due_in() > 0 then
				vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys, true, false, true), 'n', false)
				trigger_timer:start(
					trigger_debounce_ms,
					0,
					vim.schedule_wrap(function()
						if is_at_start_of_line() then
							return
						end
						vim.lsp.completion.get()
					end)
				)
				return
			end
			vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys, true, false, true), 'n', false)
		end, { desc = keys .. ' and trigger LSP completion', buffer = bufnr, expr = true })
	end

	if client:supports_method(vim.lsp.protocol.Methods.completionItem_resolve) then
		enable_completion_documentation(client, bufnr)
	end

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

vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('kjuq_user_lsp_config', {}),
	callback = on_attach,
})
