local show_on_start = true

---@type LazySpec
local spec = { 'petertriho/nvim-scrollbar' }
spec.event = show_on_start and { 'WinScrolled' } or {}

local map = require('utils.lazy').generate_map('', 'Scrollbar: ')
spec.keys = {
	map('<leader>as', 'n', function()
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
