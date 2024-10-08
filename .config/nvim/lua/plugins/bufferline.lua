local map = require('utils.lazy').generate_map('', 'Bufferline: ')

---@type LazySpec
local spec = { 'akinsho/bufferline.nvim' }
-- spec.version = "*"
spec.event = { 'BufNew', 'WinScrolled' }

spec.keys = {
	map('<C-Tab>', 'n', '<Cmd>BufferLineCycleNext<CR>', 'Pick'),
	map('gt', 'n', '<Cmd>BufferLineCycleNext<CR>', 'Pick'),
	map('<C-S-Tab>', 'n', '<Cmd>BufferLineCyclePrev<CR>', 'Pick'),
	map('gT', 'n', '<Cmd>BufferLineCyclePrev<CR>', 'Pick'),
	map('gL', 'n', '<Cmd>BufferLineCloseOthers<CR>', 'Close others'),

	map('<leader>bs', 'n', '<Cmd>BufferLinePick<CR>', 'Select'),
	map('<leader>bi', 'n', '<Cmd>BufferLineTogglePin<CR>', 'Pin'),
	map('<leader>bh', 'n', '<Cmd>BufferLineMovePrev<CR>', 'Move left'),
	map('<leader>bl', 'n', '<Cmd>BufferLineMoveNext<CR>', 'Move right'),

	map('<leader>bd', 'n', '<Cmd>BufferLineSortByDirectory<CR>', 'Sort by directory'),
	map('<leader>br', 'n', '<Cmd>BufferLineSortByRelativeDirectory<CR>', 'Sort by relative directory'),
	map('<leader>bx', 'n', '<Cmd>BufferLineSortByExtension<CR>', 'Sort by extension'),

	map('<leader>b^', 'n', function()
		require('bufferline').go_to(1, true)
	end, 'Go to left most buffer'),
	map('<leader>b0', 'n', function()
		require('bufferline').go_to(1, true)
	end, 'Go to left most buffer'),

	map('<leader>b$', 'n', function()
		require('bufferline').go_to(-1, true)
	end, 'Go to right most buffer'),

	map('<leader>ab', 'n', function()
		if vim.o.showtabline == 0 then
			vim.opt.showtabline = 2
		else
			vim.opt.showtabline = 0
		end
	end, 'Toggle tabline'),
}

spec.config = function()
	-- local transparent = "#000000"
	require('bufferline').setup({
		options = {
			numbers = 'none', -- "ordinal", "buffer_id", "both"
			diagnostics = 'nvim_lsp',
			always_show_bufferline = false,
			separator_style = { '|', '|' }, -- "slant", "slope", "thick", "thin", { "", "" }
			indicator = { style = 'none' }, -- "icon", "underline", "none"
			show_buffer_close_icons = false,
			color_icons = true,
			sort_by = 'insert_at_end',
			groups = {
				items = {
					require('bufferline.groups').builtin.pinned:with({ icon = '' }),
				},
			},
			offsets = {
				{
					filetype = 'neo-tree',
					text = 'Neo Tree',
					highlight = 'Directory',
					separator = true, -- use a "true" to enable the default, or set your own character
				},
				{
					filetype = 'dapui_watches',
					text = 'DAP UI',
					highlight = 'Directory',
					separator = true, -- use a "true" to enable the default, or set your own character
				},
			},
		},
		highlights = {
			separator = { fg = '#777777' },
			-- Needed when using separator
			-- fill                   = { bg = transparent, },
			-- tab_separator          = { fg = transparent, },
			-- tab_separator_selected = { fg = transparent, },
			-- separator_selected     = { fg = transparent, bg = transparent },
			-- separator_visible      = { fg = transparent, },
			-- offset_separator       = { fg = transparent, },
		},
	})
end

spec.specs = 'nvim-tree/nvim-web-devicons'

return spec
