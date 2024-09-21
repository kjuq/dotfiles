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
	map('<leader>bb', 'n', '<Cmd>BufferLinePick<CR>', 'Pick'),
	map('<leader>bp', 'n', '<Cmd>BufferLineTogglePin<CR>', 'Pin'),
	map('<leader>bh', 'n', '<Cmd>BufferLineMovePrev<CR>', 'Move left'),
	map('<leader>bl', 'n', '<Cmd>BufferLineMoveNext<CR>', 'Move right'),
	map('<leader>bu', 'n', '<Cmd>BufferLineCloseLeft<CR>', 'Close left'),
	map('<leader>bk', 'n', '<Cmd>BufferLineCloseRight<CR>', 'Close right'),
	map('<leader>bx', 'n', '<Cmd>BufferLineCloseOthers<CR>', 'Close others'),
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
