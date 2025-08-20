---@module 'lazy'
---@type LazySpec
local spec = { 'https://github.com/neovim/nvim-lspconfig' }

spec.cmd = {
	'LspInfo',
	'LspStart',
	'LspRestart',
	'LspStop',
	'LspLog',
}

return spec
