---@param clnt vim.lsp.Client
---@param buf integer
---@param opt table? { fix_cursor, retry }
local function register_format_on_save(clnt, buf, opt)
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

---@param client vim.lsp.Client
---@param bufnr integer
local function register_inlinecompletion(client, bufnr)
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

vim.diagnostic.config({
	signs = false,
	jump = {
		-- float = true,
		on_jump = function(_, bufnr)
			vim.diagnostic.open_float({
				bufnr = bufnr,
				scope = 'cursor',
				focus = false,
				header = '',
				format = function(diagnostic)
					return string.format('%s\n⊳ %s', diagnostic.message, diagnostic.source)
				end,
			})
		end,
	},
})

vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('kjuq_user_lsp_config', {}),
	callback = function(ev)
		local bufnr = ev.buf
		-- Buffer-local keymaps
		vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'LSP: Go to definition', buffer = bufnr })
		local vl_enabled = false
		vim.keymap.set('n', '<M-d>', function()
			vim.diagnostic.config({
				virtual_lines = not vl_enabled and { current_line = true } or false,
			})
			vl_enabled = not vl_enabled
			-- TODO: disable when cursor moved beyond lines
		end, { desc = 'LSP: Toggle virtual lines of diagnostic' })
		local client_id = ev.data.client_id
		local client = assert(vim.lsp.get_client_by_id(client_id))
		register_format_on_save(client, bufnr, {
			fix_cursor = vim.tbl_contains({ 'efm' }, client.name),
		})
		if vim.fn.has('nvim-0.12') == 1 then
			vim.opt.complete = 'o'
			register_inlinecompletion(client, bufnr)
		end
	end,
})
