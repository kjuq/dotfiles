vim.api.nvim_create_autocmd({ 'LspAttach' }, {
	group = vim.api.nvim_create_augroup('kjuq_lspattach_tinymist', {}),
	callback = function(args)
		local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
		if client.name ~= 'tinymist' then
			return
		end
		local open = vim.fn.has('unix') == 1 and 'xdg-open' or 'open'
		vim.keymap.set('n', '<Space>ap', function()
			local dir = vim.fn.expand('%:p:h')
			local filename = vim.fn.expand('%:t'):gsub([[.[^.]*$]], '.pdf')
			local path = vim.fs.joinpath('/tmp/typst_output/', dir, filename)
			vim.system({ open, path }, { text = true }, function(job)
				if job.code ~= 0 then
					error(('code: %d, stderr: %s'):format(job.code, job.stderr))
				end
			end)
		end, { buffer = true, desc = 'Tinymist: Preview' })
	end,
})

local settings = {
	exportPdf = 'onType',
	outputPath = '/tmp/typst_output/$root/$dir/$name',
	formatterMode = 'typstyle', -- need to install `typstyle` via Mason
	formatterIndentSize = 4,
}

---@type vim.lsp.Config
return {
	settings = settings,
}
