vim.pack.add({ 'https://github.com/akinsho/toggleterm.nvim' })

local open_cmd = 'ToggleTerm dir=%:p:h'

vim.keymap.set('n', '<C-space>', string.format('<CMD>%s<CR>', open_cmd), { desc = 'ToggleTerm: Open' })

---@diagnostic disable-next-line: duplicate-set-field
function _G.set_terminal_keymaps()
	local opts = { buffer = 0 }
	-- vim.keymap.set("t", "<esc>", function() vim.cmd(open_cmd) end, opts)
	vim.keymap.set('t', '<C-Space>', function()
		vim.cmd(open_cmd)
	end, opts)
end

vim.api.nvim_create_autocmd({ 'TermOpen' }, {
	pattern = 'term://*toggleterm#*',
	callback = function()
		set_terminal_keymaps()
	end,
})

require('toggleterm').setup( {
	direction = 'float',
	-- float_opts = { winblend = 20, },
})
