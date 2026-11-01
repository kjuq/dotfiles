vim.pack.add({
	-- { src = 'https://github.com/nvim-tree/nvim-web-devicons' }, -- optional
	{ src = 'https://github.com/nvim-tree/nvim-tree.lua' },
})

vim.keymap.set('n', '<space>af', '<Cmd>NvimTreeOpen<CR>', { desc = 'Nvim-tree: Open' })

-- optionally depends on devicons

require('nvim-tree').setup({
	hijack_cursor = true,
	disable_netrw = true,
	hijack_directories = {
		enable = false,
		auto_open = false,
	},
	filters = {
		git_ignored = false,
	},
	view = {
		signcolumn = 'auto',
	},
	renderer = {
		icons = {
			padding = {
				folder_arrow = '  ',
				icon = '  ',
			},
			show = {
				bookmarks = false,
				diagnostics = false,
				file = true,
				folder = true,
				folder_arrow = true,
				git = false,
				-- hidden = false, -- it is false by default
				modified = false,
			},
		},
	},
})
