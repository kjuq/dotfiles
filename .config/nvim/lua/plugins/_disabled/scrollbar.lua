local show_on_start = true

---@type LazySpec
local spec = { 'https://github.com/petertriho/nvim-scrollbar' }
spec.event = show_on_start and { 'WinScrolled' } or {}

local map = require('kjuq.utils.lazy').generate_map('', 'Scrollbar: ')
spec.keys = {
	map('<Space>tp', 'n', function()
		require('scrollbar.utils').toggle()
	end, 'Toggle'),
}

spec.opts = function()
	return {
		show = show_on_start,
		excluded_filetypes = {
			'ccc-ui',
			'cmp_docs',
			'cmp_menu',
			'dap-float',
			'noice',
			'prompt',
			'TelescopePrompt',
			'saga_codeaction',
			'sagarename',
			'DressingInput',
			'dropbar_menu',
		},
	}
end

spec.dependencies = {
	{
		'kevinhwang91/nvim-hlslens',
		config = function(_, opts)
			require('scrollbar.handlers.search').setup(opts)
		end,
	},
	{
		'lewis6991/gitsigns.nvim',
		config = function(_, opts)
			require('gitsigns').setup(opts)
			require('scrollbar.handlers.gitsigns').setup()
		end,
	},
}

return spec
