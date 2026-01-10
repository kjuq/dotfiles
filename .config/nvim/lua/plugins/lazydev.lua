---@module 'lazy'
---@type LazySpec
local spec = { 'https://github.com/folke/lazydev.nvim' }

spec.cond = not os.getenv('KJUQ_NVIM_LOAD_ALL_RUNTIME_PATH')
spec.event = 'VeryLazy'

spec.config = function()
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
end

spec.dependencies = {
	'williamboman/mason.nvim',
	'neovim/nvim-lspconfig',
}

return spec
