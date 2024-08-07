---@type LazySpec
local spec = { 'yioneko/nvim-yati' }

spec.event = 'VeryLazy'

spec.config = function()
	local ts_opts = {
		yati = {
			enable = true,
			disable = {},
			default_lazy = true,
			default_fallback = 'auto',
		},
	}
	require('nvim-treesitter.configs').setup(ts_opts)
end

spec.dependencies = {
	'nvim-treesitter/nvim-treesitter',
}

return spec
