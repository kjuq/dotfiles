---@type boolean
local enable_on_start = true
---@type string
local dropbar_winbar = '%{%v:lua.dropbar.get_dropbar_str()%}'

---@type LazySpec
local spec = { 'Bekaboo/dropbar.nvim' }

spec.event = enable_on_start and 'VeryLazy' or {}

local map = require('utils.lazy').generate_map('<leader>a', 'Dropbar: ')
spec.keys = {
	map('n', 'n', function()
		vim.o.winbar = vim.o.winbar == '' and dropbar_winbar or ''
	end, 'Toggle'),
}

spec.opts = {
	bar = {
		enable = false, -- it is confortable for me to configure `vim.o.winbar` manually
		bar = {
			update_debounce = 50,
		},
	},
	menu = {
		keymaps = {
			['q'] = '<Nop>',
		},
		win_configs = {
			border = require('utils.common').floatwinborder,
		},
	},
}

spec.config = function(_, opts)
	require('dropbar').setup(opts)
	if enable_on_start then
		vim.o.winbar = dropbar_winbar
	end
end

return spec
