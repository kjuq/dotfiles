---@type LazySpec
local spec = { 'jay-babu/mason-null-ls.nvim' }
spec.event = { 'LspAttach', 'VeryLazy' }

spec.opts = function()
	local null_ls = require('null-ls')

	return {
		automatic_setup = true,
		handlers = {
			textlint = function()
				require('plugins.linter.textlint').setup()
				null_ls.register(null_ls.builtins.diagnostics.textlint)
			end,
		},
	}
end

spec.dependencies = {
	'williamboman/mason.nvim',
	'nvimtools/none-ls.nvim',
	'nvim-lua/plenary.nvim',
}

return spec
