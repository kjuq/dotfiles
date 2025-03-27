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
	require('kjuq.utils.lsp').setup()
	-- require('lspconfig.ui.windows').default_options.border = vim.o.winborder
end

return spec
