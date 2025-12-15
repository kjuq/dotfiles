-- NOTE: cutting edge
if vim.fn.has('nvim-0.12') == 0 then
	return
end

vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(ev)
		local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
		vim.api.nvim_echo({ { '[' }, { client.name }, { '] Attached' } }, true, {})
	end,
})

vim.api.nvim_create_autocmd('LspProgress', {
	callback = function(ev)
		local value = ev.data.params.value
		local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
		local label = '[' .. client.name .. ']'

		-- TODO: Show progress
		-- local status = vim.lsp.status()
		-- vim.api.nvim_echo({ { label .. ' ' .. status } }, true, {})

		if value.kind == 'begin' then
			vim.api.nvim_echo({ { label }, { ' ' }, { value.title }, { 'began' } }, true, {})
		elseif value.kind == 'end' then
			vim.api.nvim_echo({ { label }, { ' ' }, { value.title }, { ' ' }, { 'ended' } }, true, {})
		end
	end,
})
