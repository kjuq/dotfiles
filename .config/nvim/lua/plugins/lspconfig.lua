---@type LazySpec
local spec = { 'neovim/nvim-lspconfig' }

local map = require('utils.lazy').generate_map('', 'Lspconfig: ')
spec.keys = {
	map('<leader>aL', 'n', '<CMD>LspInfo<CR>', 'LspInfo'),
}

spec.config = function()
	require('core.lsp').setup()
	require('lspconfig.ui.windows').default_options.border = require('utils.common').floatwinborder
end

return spec
