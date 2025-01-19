---@type LazySpec
local spec = { 'https://github.com/ibhagwan/fzf-lua' }

spec.cmd = {
	'FzfLua',
}

local map = require('kjuq.utils.lazy').generate_map('<Space>f', 'Fzf-Lua: ')
spec.keys = {
	map('a', 'n', '<Cmd>FzfLua<CR>', 'Select from all sources'),
	map('e', 'n', '<Cmd>FzfLua files<CR>', 'Find files on current dir'),
	map('w', 'n', '<Cmd>FzfLua cWORD<CR>', 'Grep <CWORD>'),
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

spec.opts = {
	winopts = {
		border = require('kjuq.utils.common').floatwinborder,
	},
	grep = {
		rg_opts = '--hidden --glob "!.git/*" --column --line-number --no-heading --color=always --smart-case --max-columns=4096 -e',
	},
}

spec.specs = {
	'nvim-tree/nvim-web-devicons',
}

return spec
