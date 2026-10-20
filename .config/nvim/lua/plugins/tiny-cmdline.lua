if vim.fn.has('nvim-0.12') == 0 then
	return
end

vim.g.tiny_cmdline = {
	width = {
		value = '70%',
		min = 40,
		max = 150,
	},
	position = {
		x = '50%',
		y = '50%',
	},
	native_types = {}, -- `/` and `?` also use floating menu
}
vim.pack.add({ 'https://github.com/rachartier/tiny-cmdline.nvim' })
