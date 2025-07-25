local map = require('kjuq.utils.lazy').generate_map('<Space>', 'Neo-tree: ')

---@type LazySpec
local spec = { 'https://github.com/nvim-neo-tree/neo-tree.nvim' }
spec.branch = 'v3.x'
spec.cmd = { 'Neotree' }

spec.keys = {
	map('aF', 'n', function()
		require('neo-tree.command').execute({
			source = 'filesystem',
			position = 'left',
			toggle = false,
			reveal_force_cwd = true,
		})
	end, 'Open'),
	map('aG', 'n', function()
		require('neo-tree.command').execute({
			source = 'git_status',
			position = 'left',
			toggle = false,
			reveal_force_cwd = true,
		})
	end, 'Open git'),
	map('aB', 'n', function()
		require('neo-tree.command').execute({
			source = 'buffers',
			position = 'left',
			toggle = false,
			reveal_force_cwd = true,
		})
	end, 'Open buffer'),
}

spec.opts = {
	close_if_last_window = true,
	filesystem = {
		window = {
			mappings = {
				['<C-h>'] = 'navigate_up',
			},
		},
		follow_current_file = {
			enabled = true,
		},
		filtered_items = {
			visible = true, -- when true, they will just be displayed differently than normal items
			hide_dotfiles = false,
			hide_gitignored = true,
			hide_by_name = {
				'node_modules',
			},
			hide_by_pattern = { -- uses glob style patterns
				--"*.meta",
				--"*/src/*/tsconfig.json",
			},
			always_show = { -- remains visible even if other settings would normally hide it
				--".gitignored",
			},
			never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
				'.DS_Store',
			},
			never_show_by_pattern = { -- uses glob style patterns
				--".null-ls_*",
			},
		},
		hijack_netrw_behavior = 'disabled',
		use_libuv_file_watcher = true,
	},
	git_status = {},
	buffers = {
		window = {
			mappings = {
				['<C-h>'] = 'navigate_up',
			},
		},
		follow_current_file = {
			enabled = true,
		},
	},
}

spec.specs = {
	'nvim-lua/plenary.nvim',
	'nvim-tree/nvim-web-devicons',
	'MunifTanjim/nui.nvim',
}

return spec
