-- Dim inactive windows

vim.api.nvim_set_hl(0, 'kjuq_inactive_windows', { fg = 'Gray' })

-- When leaving a window, set all highlight groups to a "dimmed" hl_group
vim.api.nvim_create_autocmd({ 'WinLeave', 'FocusLost' }, {
	callback = function()
		local highlights = {}
		for hl, _ in pairs(vim.api.nvim_get_hl(0, {})) do
			table.insert(highlights, hl .. ':kjuq_inactive_windows')
		end
		vim.wo.winhighlight = table.concat(highlights, ',')
	end,
})

-- When entering a window, restore all highlight groups to original
vim.api.nvim_create_autocmd({ 'WinEnter', 'FocusGained' }, {
	callback = function()
		vim.wo.winhighlight = ''
	end,
})
