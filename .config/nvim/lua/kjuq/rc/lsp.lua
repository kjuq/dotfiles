-- ---@param dir string
-- ---@return table?
-- local listfilenames = function(dir)
-- 	local req, err = vim.uv.fs_scandir(dir)
-- 	if not req then
-- 		error(err)
-- 		return nil
-- 	end
-- 	local result = {}
-- 	while true do
-- 		local name, type = vim.uv.fs_scandir_next(req)
-- 		if not name then -- no more entries
-- 			break
-- 		end
-- 		if type == 'directory' then
-- 			goto continue
-- 		end
-- 		local filename = string.gsub(name, [[.lua$]], '')
-- 		result[#result + 1] = filename
-- 		::continue::
-- 	end
-- 	return result
-- end
--
-- -- Setup lsp without nvim-lspconfig
-- local all_ls = listfilenames(os.getenv('XDG_CONFIG_HOME') .. '/nvim/lsp') or {}
-- vim.lsp.enable(all_ls)

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

---@param ev table ref. `help event-args`
local on_attach = function(ev)
	local bufnr = ev.buf

	-- Buffer-local keymaps
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
			group = vim.api.nvim_create_augroup(
				string.format('kjuq_formatonsave_%s_buf_%d', client.name, bufnr),
				{ clear = false }
			),
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

vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('kjuq_user_lsp_config', {}),
	callback = on_attach,
})
