local M = {}

M.opts = {
	on_attach = function()
		vim.keymap.set('n', '<Space>ap', function()
			local dir = vim.fn.expand('%:p:h')
			local filename = vim.fn.expand('%:t'):gsub([[.[^.]*$]], '.pdf')
			local path = vim.fs.joinpath('/tmp/typst_output/', dir, filename)
			local cmd = string.format('silent !open %s', path)
			vim.cmd(cmd)
		end, { buffer = true })
	end,
	settings = {
		exportPdf = 'onSave',
		outputPath = '/tmp/typst_output/$root/$dir/$name',
	},
}

return M
