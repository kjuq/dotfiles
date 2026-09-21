vim.pack.add({
	{
		src = 'https://github.com/nvim-neo-tree/neo-tree.nvim',
		version = vim.version.range('3'),
	},
	'https://github.com/nvim-lua/plenary.nvim',
	'https://github.com/MunifTanjim/nui.nvim',
})

vim.keymap.set('n', 'af', function()
	require('neo-tree.command').execute({
		source = 'filesystem',
		position = 'left',
		toggle = false,
		reveal_force_cwd = true,
	})
end, { desc = 'Neo-Tree: Open' })

vim.keymap.set('n', 'ag', function()
	require('neo-tree.command').execute({
		source = 'git_status',
		position = 'left',
		toggle = false,
		reveal_force_cwd = true,
	})
end, { desc = 'Neo-Tree: Open git' })

vim.keymap.set('n', 'ab', function()
	require('neo-tree.command').execute({
		source = 'buffers',
		position = 'left',
		toggle = false,
		reveal_force_cwd = true,
	})
end, { desc = 'Neo-Tree: Open buffer' })

require('neo-tree').setup({
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
})

-- depends on plenary.nvim and nui.nvim
