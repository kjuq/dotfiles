---@type LazySpec
local spec = { 'bennypowers/nvim-regexplainer' }

local map = require('utils.lazy').generate_map('', 'Regexplainer: ')
spec.keys = {
	map('<leader>aR', 'n', function()
		require('regexplainer').show()
	end, 'Show'),
}

spec.opts = {
	auto = false,
	mappings = {
		toggle = '<Nop>', -- disable gR which is the default keymap
	},
	---@diagnostic disable-next-line: missing-fields
	popup = {
		border = {
			padding = { 0, 1 },
			style = require('utils.common').floatwinborder,
		},
	},
}

spec.config = function(_, opts)
	require('regexplainer').setup(opts)
	if not opts.auto then
		vim.defer_fn(function()
			require('regexplainer').show()
		end, 0)
	end
end

spec.dependencies = {
	'nvim-treesitter/nvim-treesitter',
}

spec.specs = {
	'MunifTanjim/nui.nvim',
}

return spec
