if not os.getenv('KJUQ_NVIM_LOAD_ALL_RUNTIME_PATH') then
	vim.pack.add({ 'https://github.com/folke/lazydev.nvim' })
end

local setup = function()
	require('lazydev').setup({
		library = {
			vim.fs.joinpath(vim.fn.stdpath('config'), '/lua'),
		},
	})
end

if vim.bo.filetype == 'lua' then
	setup()
else
	vim.api.nvim_create_autocmd({ 'FileType' }, {
		pattern = 'lua',
		group = vim.api.nvim_create_augroup('kjuq_lazyload_lazydev', {}),
		callback = setup,
		once = true,
	})
end

-- depends on nvim-lspconfig
