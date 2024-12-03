---@type LazySpec
local spec = { 'neovim/nvim-lspconfig' }

local map = require('utils.lazy').generate_map('', 'Lspconfig: ')
spec.keys = {
	map('<Space>aL', 'n', '<CMD>LspInfo<CR>', 'LspInfo'),
}

spec.config = function()
	require('utils.lsp').setup()
	require('lspconfig.ui.windows').default_options.border = require('utils.common').floatwinborder
end

return spec
