---@module 'lazy'
---@type LazySpec
local spec = { 'https://github.com/nvim-telescope/telescope.nvim' }
spec.cmd = { 'Telescope' }

local map = require('kjuq.lazy').generate_map('<Space>', 'Telescope: ')
spec.keys = {
	-- File pickers
	map('fe', 'n', '<Cmd>Telescope find_files hidden=true<CR>', 'Files on current dir'),
	map('fw', 'n', '<Cmd>Telescope grep_string<CR>', 'Word on the cursor'),
	map('fg', 'n', '<Cmd>Telescope live_grep<CR>', 'Live grep'),
	map('fG', 'n', '<Cmd>Telescope git_files<CR>', 'Git files'),

	-- Vim pickers
	map('fh', 'n', '<Cmd>Telescope oldfiles only_cwd=true<CR>', 'MRU for current dir'),
	map('fH', 'n', '<Cmd>Telescope oldfiles only_cwd=false<CR>', 'MRU for current dir'),
	map('fr', 'n', '<Cmd>Telescope resume<CR>', 'Resume finding'),

	-- NOTE: Probably can make my own pickers
	map('fC', 'n', '<Cmd>Telescope highlights<CR>', 'Highlights'),
	map('fm', 'n', '<Cmd>Telescope man_pages<CR>', 'Man pages'),
	map('f:', 'n', '<Cmd>Telescope command_history<CR>', 'Commands history'),
	map('f/', 'n', '<Cmd>Telescope search_history<CR>', 'Search history'),
	map('fi', 'n', '<Cmd>Telescope help_tags<CR>', 'Help tags'),
	map('fb', 'n', '<Cmd>Telescope buffers<CR>', 'Buffers'),
	map('fk', 'n', '<Cmd>Telescope keymaps<CR>', 'Keymaps'),
	map('fq', 'n', '<Cmd>Telescope quickfixhistory<CR>', 'Quickfix history'),
	map('fs', 'n', function()
		require('telescope.builtin').symbols({ sources = { 'emoji', 'kaomoji', 'gitmoji', 'nerd' } })
	end, 'Symbols'),
}

spec.opts = function()
	local actions = require('telescope.actions')
	local actions_layout = require('telescope.actions.layout')
	local prev_up = require('kjuq.common_params').floatscrollup
	local prev_down = require('kjuq.common_params').floatscrolldown
	local prev_right = '<M-l>'
	local prev_left = '<M-h>'

	return {
		defaults = {
			default_mappings = {
				i = {
					['<C-n>'] = actions.move_selection_next,
					['<C-p>'] = actions.move_selection_previous,
					['<C-c>'] = actions.close,
					['<CR>'] = actions.select_default,
					['<C-s>'] = actions.select_vertical,
					[prev_up] = actions.preview_scrolling_up,
					[prev_down] = actions.preview_scrolling_down,
					[prev_left] = actions.preview_scrolling_left,
					[prev_right] = actions.preview_scrolling_right,
					['<Tab>'] = actions.toggle_selection + actions.move_selection_worse,
					['<S-Tab>'] = actions.toggle_selection + actions.move_selection_better,
					['<C-q>'] = actions.send_to_qflist + actions.open_qflist,
					['<M-q>'] = actions.send_selected_to_qflist + actions.open_qflist,
					['<C-l>'] = actions.complete_tag,
					['<C-g>?'] = actions.which_key, -- keys from pressing <C-/>
					['<C-w>'] = { '<c-s-w>', type = 'command' },
					-- disable c-j because we dont want to allow new lines #2123
					['<C-j>'] = actions.nop,
				},

				n = {
					['<esc>'] = actions.close,
					['<CR>'] = actions.select_default,
					['<C-s>'] = actions.select_vertical,
					['<Tab>'] = actions.toggle_selection + actions.move_selection_worse,
					['<S-Tab>'] = actions.toggle_selection + actions.move_selection_better,
					['<C-q>'] = actions.send_to_qflist + actions.open_qflist,
					['<M-q>'] = actions.send_selected_to_qflist + actions.open_qflist,
					['j'] = actions.move_selection_next,
					['k'] = actions.move_selection_previous,
					['<C-n>'] = actions.move_selection_next,
					['<C-p>'] = actions.move_selection_previous,
					['gg'] = actions.move_to_top,
					['G'] = actions.move_to_bottom,
					[prev_up] = actions.preview_scrolling_up,
					[prev_down] = actions.preview_scrolling_down,
					[prev_left] = actions.preview_scrolling_left,
					[prev_right] = actions.preview_scrolling_right,
					['g?'] = actions.which_key,
				},
			},

			mappings = {
				i = {
					['<esc>'] = actions.close,
					['<C-c>'] = { '<esc>', type = 'command' },
					['<M-n>'] = actions.cycle_history_next,
					['<M-p>'] = actions.cycle_history_prev,
					['<C-b>'] = { '<Left>', type = 'command' },
					['<C-f>'] = { '<Right>', type = 'command' },
					['<C-a>'] = { '<Home>', type = 'command' },
					['<C-d>'] = { '<Del>', type = 'command' },
				},

				n = {
					['<esc>'] = actions.close,
					['K'] = actions_layout.toggle_preview,
					['<M-n>'] = actions.cycle_history_next,
					['<M-p>'] = actions.cycle_history_prev,
				},
			},

			sorting_strategy = 'ascending',
			layout_strategy = 'flex', -- center, vertical, horizontal, flex
			layout_config = {
				height = 0.8,
				width = 0.8,
				prompt_position = 'top',
			},
			scroll_strategy = 'limit',
			path_display = { truncate = 3 },
			-- preview = {
			-- 	hide_on_startup = false,
			-- },
			vimgrep_arguments = {
				'rg',
				'--hidden',
				'--color=never',
				'--no-heading',
				'--with-filename',
				'--line-number',
				'--column',
				'--smart-case',
			},
			file_ignore_patterns = {
				'.git/',
				'node_modules/',
			},
			borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' }, -- presets such as "single" and "rounded" are not supported
		},
	}
end

spec.specs = {
	'nvim-lua/plenary.nvim',
}

return spec
