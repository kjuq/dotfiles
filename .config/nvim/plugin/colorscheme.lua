vim.api.nvim_create_autocmd({ 'ColorScheme' }, {
	group = vim.api.nvim_create_augroup('kjuq_override_colorscheme', {}),
	callback = function()
		if vim.o.background == 'light' then
			vim.api.nvim_set_hl(0, 'Cursor', { bg = 'Black' })
		elseif vim.o.background == 'dark' then
			vim.api.nvim_set_hl(0, 'DiagnosticUnnecessary', { underdotted = true, fg = 'NONE', bg = 'NONE' })
			vim.api.nvim_set_hl(0, 'StatusLine', { bg = 'NONE', ctermbg = 'NONE' })
			vim.api.nvim_set_hl(0, 'StatusLineNC', { bg = 'NONE', ctermbg = 'NONE' })
			vim.api.nvim_set_hl(0, 'WinSeparator', { fg = 'DarkGray' })
			vim.api.nvim_set_hl(0, 'VertSplit', { link = 'WinSeparator' })
			vim.api.nvim_set_hl(0, 'Cursor', { bg = 'LightGreen' })
		end
	end,
})

-- load built-in colorscheme if no colorscheme is loaded by plugin manager
if vim.g.colors_name == nil then
	vim.cmd.colorscheme('slate') -- 'default'|'slate'|'habamax'|'retrobox'|'sorbet'|'unokai'
	if _G.kjuq_colorscheme_transparent == nil and true or _G.kjuq_colorscheme_transparent then
		vim.api.nvim_set_hl(0, 'Normal', { bg = 'NONE', ctermbg = 'NONE' }) -- background
	end
end
