local M = {}

M.opts = {
	on_attach = function()
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
		end, { buffer = true })
	end,
	settings = {
		exportPdf = 'onSave',
		outputPath = '/tmp/typst_output/$root/$dir/$name',
	},
}

return M
