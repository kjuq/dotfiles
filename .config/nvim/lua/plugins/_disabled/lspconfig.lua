---@type LazySpec
local spec = { 'neovim/nvim-lspconfig' }

spec.cmd = {
	'LspInfo',
	'LspStart',
	'LspRestart',
	'LspStop',
	'LspLog',
}

spec.event = 'LspAttach'

return spec
