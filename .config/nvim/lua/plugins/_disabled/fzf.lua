---@module 'lazy'
---@type LazySpec
local spec = { 'https://github.com/ibhagwan/fzf-lua' }

spec.cmd = {
	'FzfLua',
}

local map = require('kjuq.utils.lazy').generate_map('<Space>f', 'Fzf-Lua: ')
spec.keys = {
	map('a', 'n', '<Cmd>FzfLua<CR>', 'Select from all sources'),
	map('e', 'n', '<Cmd>FzfLua files<CR>', 'Find files on current dir'),
	map('w', 'n', '<Cmd>FzfLua grep_cword<CR>', 'Grep <CWORD>'),
	map('g', 'n', '<Cmd>FzfLua live_grep<CR>', 'Live grep'),
	map('G', 'n', '<Cmd>FzfLua git_files<CR>', 'Git files'),
	map('h', 'n', '<Cmd>FzfLua oldfiles<CR>', 'MRU'),
	map('H', 'n', '<Cmd>FzfLua oldfiles cwd="%:p:h"<CR>', ''),
	map('b', 'n', '<Cmd>FzfLua buffers<CR>', 'Buffers'),
	map('i', 'n', '<Cmd>FzfLua helptags<CR>', 'Help tags'),
	map('m', 'n', '<Cmd>FzfLua marks<CR>', 'Marks'),
	map('Q', 'n', '<Cmd>FzfLua quickfix<CR>', 'Quickfix'),
	map('R', 'n', '<Cmd>FzfLua registers<CR>', 'Registers'),
	map('k', 'n', '<Cmd>FzfLua keymaps<CR>', 'Keymaps'),
	map('n', 'n', '<Cmd>FzfLua grep_curbuf<CR>', 'Grep current buffer'),
	map('M', 'n', '<Cmd>FzfLua manpages<CR>', 'Man pages'),
	map('r', 'n', '<Cmd>FzfLua resume<CR>', 'Resume last search'),
}

spec.opts = function()
	local actions = require('fzf-lua.actions')
	return {
		winopts = {
			border = vim.o.winborder,
			preview = {
				layout = 'horizonal',
			},
		},
		grep = {
			rg_opts = '--hidden --glob "!.git/*" --column --line-number --no-heading --color=always --smart-case --max-columns=4096 -e',
		},
		keymap = {
			builtin = {
				['<Esc>'] = 'hide', -- hide fzf-lua, `:FzfLua resume` to continue
				['<F1>'] = 'toggle-help',
				['<F11>'] = 'toggle-fullscreen',

				['<F2>'] = 'toggle-preview-wrap', -- Only valid with the 'builtin' previewer
				['<F3>'] = 'toggle-preview-ccw',
				['<F5>'] = 'preview-reset',
				['<F6>'] = 'toggle-preview',

				['<F7>'] = 'toggle-preview-ts-ctx', -- `ts-ctx` binds require `nvim-treesitter-context`
				['<F8>'] = 'preview-ts-ctx-dec',
				['<F9>'] = 'preview-ts-ctx-inc',
				[require('kjuq.utils.common').floatscrolldown] = 'preview-down',
				[require('kjuq.utils.common').floatscrollup] = 'preview-up',
			},
			fzf = {
				-- fzf '--bind=' options
				['ctrl-z'] = 'abort',
				['ctrl-u'] = 'unix-line-discard',
				['ctrl-f'] = 'forward-char',
				['ctrl-b'] = 'backward-char',
				['ctrl-a'] = 'beginning-of-line',
				['ctrl-e'] = 'end-of-line',
				['alt-a'] = 'toggle-all',
				['alt-g'] = 'first',
				['alt-G'] = 'last',
				-- Only valid with fzf previewers (bat/cat/git/etc)
				['f2'] = 'toggle-preview-wrap',
				['f6'] = 'toggle-preview',
				['alt-f'] = 'preview-page-down',
				['alt-b'] = 'preview-page-up',
			},
		},
		actions = {
			files = {
				['enter'] = actions.file_edit_or_qf,
				['ctrl-s'] = actions.file_split,
				['ctrl-v'] = actions.file_vsplit,
				['alt-q'] = actions.file_sel_to_qf,
				['alt-h'] = { fn = actions.toggle_hidden, reuse = true, header = false },
				['alt-i'] = { fn = actions.toggle_ignore, reuse = true, header = false }, -- respect ".gitignore"
				['alt-l'] = { fn = actions.toggle_follow, reuse = true, header = false }, -- follow symlink
			},
		},
	}
end

spec.specs = {
	'nvim-tree/nvim-web-devicons',
}

return spec
