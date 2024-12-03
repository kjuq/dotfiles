---@type LazySpec
local spec = { 'stevearc/oil.nvim' }

spec.lazy = not require('utils.common').argv_contains('oil-ssh://')

spec.event = 'VeryLazy'

local map = require('utils.lazy').generate_map('', 'Oil: ')
spec.keys = {
	map('<Space>-', 'n', '<CMD>Oil<CR>', 'Open'),
}

spec.init = function()
	vim.g.loaded_netrwPlugin = 1
end

spec.opts = function()
	local hiddens = { '.DS_Store', '.git', '.gitmodules', 'node_modules' }

	return {
		delete_to_trash = true,
		skip_confirm_for_simple_edits = true,
		cleanup_delay_ms = 1000,
		keymaps = {
			['g?'] = 'actions.show_help',
			['<CR>'] = 'actions.select',
			['<C-s>'] = 'actions.select_vsplit',
			['g<C-s>'] = 'actions.select_split',
			['K'] = 'actions.preview',
			['<C-Tab>'] = 'actions.close',
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
				return vim.list_contains(hiddens, name)
			end,
		},
	}
end

spec.specs = { 'nvim-tree/nvim-web-devicons' }

return spec
