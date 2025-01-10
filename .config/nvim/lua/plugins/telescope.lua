local map = require('kjuq.utils.lazy').generate_map('<Space>', 'Telescope: ')
local tb = 'telescope.builtin'

---@type LazySpec
local spec = { 'nvim-telescope/telescope.nvim' }
spec.cmd = { 'Telescope' }

spec.keys = {
	-- File pickers
	map('fe', 'n', function()
		require(tb).find_files({ hidden = true })
	end, 'Files on current dir'),
	map('fw', 'n', function()
		require(tb).grep_string()
	end, 'Word on the cursor'),
	map('fg', 'n', function()
		require(tb).live_grep()
	end, 'Live grep'),
	map('gf', 'n', function()
		require(tb).git_files()
	end, 'Git files'),

	-- Vim pickers
	map('fH', 'n', function()
		require(tb).oldfiles({ only_cwd = true })
	end, 'MRU for current dir'),
	map('fh', 'n', function()
		require(tb).oldfiles({ only_cwd = false })
	end, 'MRU for global files'),
	map('fb', 'n', function()
		require(tb).buffers()
	end, 'Buffers'),
	map('fi', 'n', function()
		require(tb).help_tags()
	end, 'Help tags'),
	map('fm', 'n', function()
		require(tb).marks()
	end, 'Marks'),
	map('fQ', 'n', function()
		require(tb).quickfix()
	end, 'Quickfix'),
	map('fr', 'n', function()
		require(tb).registers()
	end, 'Registers'),
	map('fk', 'n', function()
		require(tb).keymaps()
	end, 'Keymaps'),
	map('fn', 'n', function()
		require(tb).current_buffer_fuzzy_find()
	end, 'Fuzzy search'),
	map('fc', 'n', function()
		require(tb).command_history()
	end, 'Commands history'),
	map('fN', 'n', function()
		require(tb).search_history()
	end, 'Search history'),
	map('fM', 'n', function()
		require(tb).man_pages()
	end, 'Man pages'),
	map('fq', 'n', function()
		require(tb).quickfixhistory()
	end, 'Quickfix history'),
	map('fL', 'n', function()
		require(tb).loclist()
	end, 'Loclist'),
	map('fj', 'n', function()
		require(tb).jumplist()
	end, 'Jumplist'),
	map('fC', 'n', function()
		require(tb).highlights()
	end, 'Highlights'),
	map('rf', 'n', function()
		require(tb).resume()
	end, 'Resume finding'),

	-- Neovim LSP pickers
	-- using lspsaga's same function now
	-- map("<KEYBIND>", "n", function() require(tb).lsp_references() end, "Lsp references"),
	-- map("<KEYBIND>", "n", function() require(tb).lsp_incoming_calls() end, "Incoming calls"),
	-- map("<KEYBIND>", "n", function() require(tb).lsp_outgoing_calls() end, "Outgoing calls"),
	map('fd', 'n', function()
		require(tb).diagnostics()
	end, 'Diagnostics'),
	map('fS', 'n', function()
		require(tb).lsp_document_symbols()
	end, 'Document symbols'),
	map('fW', 'n', function()
		require(tb).lsp_dynamic_workspace_symbols()
	end, 'Doc Symbols'),
	map('fI', 'n', function()
		require(tb).lsp_implementations()
	end, 'Implementations'),
	map('fD', 'n', function()
		require(tb).lsp_definitions()
	end, 'Definitions'),
	map('fT', 'n', function()
		require(tb).lsp_type_definitions()
	end, 'Type definitions'),

	-- Git pickers

	-- Treesitter pickers
	-- I have no idea when I should use this
	-- map('', 'n', function()
	-- 	require(tb).treesitter()
	-- end, 'Find via treesitter'),

	-- Lists pickers
	map('fs', 'n', function()
		require(tb).symbols({ sources = { 'emoji', 'kaomoji', 'gitmoji', 'nerd' } })
	end, 'Symbols'),
}

spec.opts = function()
	local actions = require('telescope.actions')
	local actions_layout = require('telescope.actions.layout')
	local prev_up = require('kjuq.utils.common').floatscrollup
	local prev_down = require('kjuq.utils.common').floatscrolldown
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

			layout_strategy = 'vertical', -- center, vertical, horizontal, flex
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
	'nvim-lua/popup.nvim',
	'nvim-lua/plenary.nvim',
	'BurntSushi/ripgrep',
}

spec.dependencies = {
	'nvim-telescope/telescope-symbols.nvim',
	{
		'nvim-telescope/telescope-fzf-native.nvim',
		build = 'make',
		cond = (vim.fn.executable('gcc') == 1 or vim.fn.executable('clang') == 1) and vim.fn.executable('make') == 1,
		config = function()
			require('telescope').load_extension('fzf')
		end,
	},
}

return spec
