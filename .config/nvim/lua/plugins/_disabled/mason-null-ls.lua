---@type LazySpec
local spec = { 'https://github.com/jay-babu/mason-null-ls.nvim' }
spec.event = { 'LspAttach', 'VeryLazy' }

spec.opts = function()
	return {
		automatic_setup = true,
		handlers = {
			textlint = require('plugins.linter.textlint').setup,
			clang_format = require('plugins.formatter.clang_format').setup,
		},
	}
end

spec.dependencies = {
	'williamboman/mason.nvim',
	'nvimtools/none-ls.nvim',
}

spec.specs = {
	'nvim-lua/plenary.nvim',
}

return spec
