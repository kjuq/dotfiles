---@module 'lazy'
---@type LazySpec
local spec = { 'https://github.com/echasnovski/mini.nvim' }

spec.event = 'VeryLazy'

spec.config = function()
	do
		require('mini.pick').setup({
			delay = {
				-- Delay between forcing asynchronous behavior
				async = 1,
				-- Delay between computation start and visual feedback about it
				busy = 20,
			},
			mappings = {
				caret_left = '<Left>',
				caret_right = '<Right>',

				choose = '<CR>',
				choose_in_split = '<C-s>',
				choose_in_tabpage = '',
				choose_in_vsplit = '<C-v>',
				choose_marked = '<S-CR>',

				delete_char = '<BS>',
				delete_char_right = '<Del>',
				delete_left = '<C-u>',
				delete_word = '<C-w>',

				mark = '<C-x>',
				mark_all = '<C-a>',

				move_down = '<C-n>',
				move_start = '<C-g>',
				move_up = '<C-p>',

				paste = '<C-r>',

				refine = '<C-k ',
				refine_marked = '<C-t>',

				scroll_down = '<PageDown>',
				scroll_left = '<C-Left>', -- <M-b>
				scroll_right = '<C-Right>', -- <M-f>
				scroll_up = '<PageUp>',

				stop = '<Esc>',

				toggle_info = '<S-Tab>',
				toggle_preview = '<Tab>',
			},
		})
		require('mini.extra').setup()
		vim.keymap.set('n', '<Space>fe', '<Cmd>Pick files<CR>', { desc = 'MiniPick: files' })
		vim.keymap.set('n', '<Space>fg', '<Cmd>Pick grep_live<CR>', { desc = 'MiniPick: grep_live' })
		vim.keymap.set('n', '<Space>fG', '<Cmd>Pick git_files<CR>', { desc = 'MiniPick: git_files' })
		vim.keymap.set('n', '<Space>fi', '<Cmd>Pick help<CR>', { desc = 'MiniPick: help tags' })
		vim.keymap.set('n', '<Space>fk', '<Cmd>Pick keymaps<CR>', { desc = 'MiniPick: keymaps' })
		vim.keymap.set('n', '<Space>fb', '<Cmd>Pick buffers<CR>', { desc = 'MiniPick: buffers' })
		vim.keymap.set('n', '<Space>fh', '<Cmd>Pick oldfiles current_dir=true<CR>', { desc = 'MiniPick: oldfiles' })
		vim.keymap.set('n', '<Space>fH', '<Cmd>Pick oldfiles current_dir=false<CR>', { desc = 'MiniPick: oldfiles G' })
		vim.keymap.set('n', '<Space>fr', '<Cmd>Pick resume<CR>', { desc = 'MiniPick: resume finding' })
	end
	require('mini.git').setup()
	require('mini.icons').setup()
end

return spec
