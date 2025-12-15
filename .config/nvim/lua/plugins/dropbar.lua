---@type boolean
local enable_on_start = false
---@type string
local dropbar_winbar = '%{%v:lua.dropbar()%}'

---@module 'lazy'
---@type LazySpec
local spec = { 'https://github.com/Bekaboo/dropbar.nvim' }

spec.event = enable_on_start and 'VeryLazy' or {}

local map = require('kjuq.utils.lazy').generate_map('', 'Dropbar: ')
spec.keys = {
	map('<Space>tr', 'n', function()
		vim.wo.winbar = vim.o.winbar == '' and dropbar_winbar or ''
	end, 'Toggle'),
}

spec.init = function()
	vim.o.winbar = enable_on_start and ' ' or nil
end

spec.opts = {
	icons = {
		ui = {
			bar = {
				separator = ' > ',
			},
			menu = {
				indicator = ' > ',
			},
		},
	},
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
			border = vim.o.winborder,
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
