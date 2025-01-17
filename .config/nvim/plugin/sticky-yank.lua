-- Keep the cursor position when yanking
local cursorPreYank

vim.keymap.set({ 'n', 'x' }, 'y', function()
	cursorPreYank = vim.api.nvim_win_get_cursor(0)
	return 'y'
end, { expr = true })

vim.keymap.set('n', 'Y', function()
	cursorPreYank = vim.api.nvim_win_get_cursor(0)
	return 'y$'
end, { expr = true })

vim.api.nvim_create_autocmd('TextYankPost', {
	callback = function()
		if vim.v.event.operator == 'y' and cursorPreYank then
			vim.api.nvim_win_set_cursor(0, cursorPreYank)
		end
	end,
})
