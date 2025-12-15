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
				busy = 50,
			},
			mappings = {
				caret_left = '<C-b>',
				caret_right = '<C-f>',

				choose = '<CR>',
				choose_in_split = '<C-s>',
				choose_in_tabpage = '',
				choose_in_vsplit = '<C-v>',
				choose_marked = '<M-CR>',

				delete_char = '<C-h>',
				delete_char_right = '<C-d>',
				delete_left = '<C-u>',
				delete_word = '<C-w>',

				mark = '<C-x>',
				mark_all = '',

				move_down = '<C-n>',
				move_start = '<C-g>',
				move_up = '<C-p>',

				paste = '<C-r>',

				refine = '<C-Space>',
				refine_marked = '<M-Space>',

				scroll_down = '<M-n>',
				scroll_left = '<M-b>',
				scroll_right = '<M-f>',
				scroll_up = '<M-p>',

				stop = '<Esc>',

				toggle_info = '<S-Tab>',
				toggle_preview = '<Tab>',
			},
		})
	end
	do
		require('mini.sessions').setup()
		vim.keymap.set('n', '<Space>sl', '<Cmd>lua MiniSessions.read()<CR>', { desc = 'Mini.sessions: Read' })
		vim.api.nvim_create_autocmd({ 'VimLeavePre' }, {
			group = vim.api.nvim_create_augroup('kjuq_mini_sessions', {}),
			callback = function()
				MiniSessions.write('mini_sessions_main')
			end,
		})
	end
	require('mini.git').setup()
	require('mini.icons').setup()
end

return spec
