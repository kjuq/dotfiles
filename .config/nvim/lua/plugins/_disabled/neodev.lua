---@type LazySpec
local spec = { 'folke/neodev.nvim' }
spec.ft = { 'lua' }

spec.opts = {
	library = {
		plugins = { 'nvim-dap-ui' },
		types = true,
	},
}

spec.dependencies = {
	'neovim/nvim-lspconfig',
}

return spec
