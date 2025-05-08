---@type LazySpec
local spec = { 'williamboman/mason-lspconfig.nvim' }
spec.event = 'VeryLazy'

spec.opts = {}

spec.dependencies = {
	'neovim/nvim-lspconfig',
	'williamboman/mason.nvim',
}

return spec
