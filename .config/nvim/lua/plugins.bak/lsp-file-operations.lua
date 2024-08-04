---@type LazySpec
local spec = { 'antosha417/nvim-lsp-file-operations' }
spec.event = { 'LspAttach' }

spec.config = function() require('lsp-file-operations').setup() end

spec.dependencies = {
	'nvim-lua/plenary.nvim',
}

return spec
