---@module 'lazy'
---@type LazySpec
local spec = { 'https://github.com/echasnovski/mini.nvim' }

spec.event = 'VeryLazy'

spec.config = function()
	do
		require('mini.align').setup({
			-- Module mappings. Use `''` (empty string) to disable one.
			mappings = {
				start = 'ga',
				start_with_preview = 'gA',
			},
		})
	end
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
		vim.keymap.set('n', '<Space>fe', '<Cmd>Pick files<CR>', { desc = 'Mini: pick files' })
		vim.keymap.set('n', '<Space>fg', '<Cmd>Pick grep_live<CR>', { desc = 'Mini: pick grep_live' })
		vim.keymap.set('n', '<Space>fG', '<Cmd>Pick git_files<CR>', { desc = 'Mini: pick git_files' })
		vim.keymap.set('n', '<Space>fi', '<Cmd>Pick help<CR>', { desc = 'Mini: Pick help tags' })
		vim.keymap.set('n', '<Space>fb', '<Cmd>Pick buffers<CR>', { desc = 'Mini: Pick buffers' })
		vim.keymap.set('n', '<Space>fh', '<Cmd>Pick oldfiles current_dir=true<CR>', { desc = 'Mini: MRU current dir' })
		vim.keymap.set('n', '<Space>fH', '<Cmd>Pick oldfiles current_dir=false<CR>', { desc = 'Mini: MRU' })
		vim.keymap.set('n', '<Space>fr', '<Cmd>Pick resume<CR>', { desc = 'Mini: Pick resume finding' })
	end
	-- do
	-- 	require('mini.sessions').setup({
	-- 		autowrite = false,
	-- 	})
	-- 	vim.keymap.set('n', '<Space>sl', '<Cmd>lua MiniSessions.read()<CR>', { desc = 'Mini.sessions: Read' })
	-- 	vim.api.nvim_create_autocmd({ 'VimLeavePre' }, {
	-- 		group = vim.api.nvim_create_augroup('kjuq_mini_sessions', {}),
	-- 		callback = function()
	-- 			MiniSessions.write('mini_sessions_main')
	-- 		end,
	-- 	})
	-- end
	require('mini.surround').setup({
		highlight_duration = require('kjuq.common_params').highlight_duration,
		silent = true,
	})
	require('mini.operators').setup({
		evaluate = { prefix = '' },
		exchange = { prefix = '' },
		multiply = { prefix = '' },
		sort = { prefix = '' },
		replace = { -- substitution for 'gbprod/substitute.nvim'
			prefix = 'st',
			reindent_linewise = true,
		},
	})
	require('mini.git').setup()
	require('mini.icons').setup()
end

return spec
