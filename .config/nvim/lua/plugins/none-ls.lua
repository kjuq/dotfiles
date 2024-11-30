---@type LazySpec
local spec = { 'nvimtools/none-ls.nvim' }

spec.opts = {
	on_attach = function(client, bufnr)
		vim.api.nvim_create_autocmd('BufWritePre', {
			group = vim.api.nvim_create_augroup('kjuq_formatonsave_null_ls_' .. tostring(bufnr), {}),
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.format({ async = false, id = client.id })
			end,
		})
	end,
}

spec.specs = {
	'nvim-lua/plenary.nvim',
}

return spec
