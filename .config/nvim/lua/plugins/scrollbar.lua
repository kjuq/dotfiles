-- === Remove this line and `version = 'refactor/v2'` after 2026-11-16 ====
vim.g.scrollbar_v2_notice = false
-- ========================================================================

-- vim.pack.add({ 'https://github.com/petertriho/nvim-scrollbar' })
vim.pack.add({ { src = 'https://github.com/petertriho/nvim-scrollbar', version = 'refactor/v2' } })

vim.keymap.set('n', '<space>tp', '<Cmd>ScrollbarToggle<CR>', { desc = 'Scrollbar: Toggle scrollbar' })
vim.keymap.set('n', '<space>tm', '<Cmd>MinimapToggle<CR>', { desc = 'Scrollbar: Toggle minimap' })

require('scrollbar').setup({
	scrollbar = {
		enabled = true, -- `false` means disabling scrollbar entirely
		preset = 'minimal',
	},
	providers = {
		gitsigns = pcall(require, 'gitsigns'),
	},
	minimap = {
		enabled = true, -- `false` means disabling minimap entirely
		preset = 'zed',
	},
})

-- vim.cmd([[ScrollbarHide]])
vim.cmd([[MinimapHide]])
