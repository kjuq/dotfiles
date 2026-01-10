---@module 'lazy'
---@type LazySpec
local spec = { 'https://github.com/stevearc/oil.nvim' }

local argv_contains = function(patterns)
	patterns = type(patterns) == 'string' and { patterns } or patterns --[[@ as string[] ]]
	local argv = vim.fn.argv() --[[@ as string[] ]]
	for _, arg in pairs(argv) do
		for _, pattern in pairs(patterns) do
			if string.find(arg, pattern, 1, true) then
				return true
			end
		end
	end
	return false
end

spec.lazy = not argv_contains('oil-ssh://')

spec.event = 'VeryLazy'

local map = require('kjuq.lazy').generate_map('', 'Oil: ')
spec.keys = {
	map('<Space>-', 'n', '<CMD>Oil<CR>', 'Open'),
}

spec.init = function()
	vim.g.loaded_netrwPlugin = 1
end

spec.opts = {
	delete_to_trash = true,
	skip_confirm_for_simple_edits = true,
	cleanup_delay_ms = false,
	constrain_cursor = 'editable', -- 'editable' | 'name' | false
	columns = {
		-- 'icon',
		-- "permissions",
		-- 'size',
		-- 'mtime',
	},
	buf_options = {
		buflisted = false,
		bufhidden = 'hide',
	},
	keymaps = {
		['g?'] = 'actions.show_help',
		['<CR>'] = 'actions.select',
		['<C-s>'] = 'actions.select_vsplit',
		['g<C-s>'] = 'actions.select_split',
		['K'] = 'actions.preview',
		['gq'] = 'actions.close',
		['<C-l>'] = 'actions.refresh',
		['-'] = 'actions.parent',
		['+'] = 'actions.open_cwd',
		['_'] = 'actions.cd',
		['`'] = 'actions.change_sort',
		['gx'] = 'actions.open_external',
		['g.'] = 'actions.toggle_hidden',
		['g\\'] = 'actions.toggle_trash',
	},
	use_default_keymaps = false,
	view_options = {
		show_hidden = false,
		is_always_hidden = function(name, _)
			local hiddens = { '.DS_Store', '.git', '.gitmodules', 'node_modules' }
			return vim.list_contains(hiddens, name)
		end,
	},
}

return spec
