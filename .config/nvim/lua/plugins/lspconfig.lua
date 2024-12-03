---@type LazySpec
local spec = { 'neovim/nvim-lspconfig' }

spec.cmd = {
	'LspInfo',
	'LspStart',
	'LspRestart',
	'LspStop',
	'LspLog',
}

spec.config = function()
	require('utils.lsp').setup()
	require('lspconfig.ui.windows').default_options.border = require('utils.common').floatwinborder
end

return spec
