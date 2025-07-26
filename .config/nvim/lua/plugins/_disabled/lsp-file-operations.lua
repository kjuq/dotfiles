---@type LazySpec
local spec = { 'https://github.com/antosha417/nvim-lsp-file-operations' }
spec.event = { 'LspAttach' }

spec.config = function()
	require('lsp-file-operations').setup()
end

spec.specs = {
	'nvim-lua/plenary.nvim',
}

return spec
