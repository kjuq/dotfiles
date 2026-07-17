-- NOTE: cutting edge
if vim.fn.has('nvim-0.12') == 0 then
	return
end

-- vim.api.nvim_create_autocmd('LspAttach', {
-- 	callback = function(ev)
-- 		local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
-- 		vim.api.nvim_echo({ { '[' }, { client.name }, { '] Attached' } }, true, {})
-- 	end,
-- })

vim.api.nvim_create_autocmd('LspProgress', {
	callback = function(ev)
		local value = ev.data.params.value
		local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
		vim.api.nvim_echo({ { value.message or 'done' } }, false, {
			-- id = 'lsp.' .. ev.data.client_id,
			id = 'lsp.' .. client.id,
			kind = 'progress',
			source = 'vim.lsp',
			title = '[' .. client.name .. '] ' .. value.title,
			status = value.kind ~= 'end' and 'running' or 'success',
			percent = value.percentage,
		})
	end,
})
