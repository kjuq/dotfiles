vim.g.md_render_max_width = 120
vim.g.md_render_blank_line_after_heading = true

-- vim.opt.runtimepath:prepend('~/kjuq/ghq/github.com/kjuq/md-render.nvim')
vim.pack.add({ 'https://github.com/delphinus/md-render.nvim' })

-- optional:
vim.pack.add({ 'https://github.com/delphinus/budoux.lua' })
-- vim.pack.add({ 'https://github.com/nvim-tree/nvim-web-devicons', })

vim.api.nvim_create_autocmd({ 'FileType' }, {
	pattern = 'markdown',
	group = vim.api.nvim_create_augroup('kjuq_mdrender_keymap', {}),
	callback = function()
		vim.keymap.set('n', '<space>ap', function()
			require('md-render').preview.toggle({ max_width = vim.api.nvim_win_get_width(0) - 4 })
		end, { desc = 'md-render: Toggle preview' })
	end,
})

vim.api.nvim_create_autocmd({ 'BufEnter' }, {
	-- pattern = 'md-render',
	group = vim.api.nvim_create_augroup('kjuq_mdrender_options', {}),
	callback = function()
		if vim.o.ft ~= 'md-render' then
			return
		end
		vim.wo.wrap = true
	end,
})
