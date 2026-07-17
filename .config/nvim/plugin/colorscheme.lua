local function override_hl(ns_id, name, overrides)
	local hl = vim.api.nvim_get_hl(ns_id, { name = name, link = false }) --[[@as vim.api.keyset.highlight]]
	for k, v in pairs(overrides) do
		hl[k] = v ~= 'NONE' and v or nil
	end
	vim.api.nvim_set_hl(ns_id, name, hl)
end

local function preference()
	if vim.o.background == 'light' then
		override_hl(0, 'Cursor', { bg = 'Black' })
	elseif vim.o.background == 'dark' then
		override_hl(0, 'DiagnosticUnnecessary', { underdotted = true, fg = 'NONE', bg = 'NONE' })
		override_hl(0, 'StatusLine', { bg = 'NONE', ctermbg = 'NONE' })
		override_hl(0, 'StatusLineNC', { bg = 'NONE', ctermbg = 'NONE' })
		override_hl(0, 'WinSeparator', { fg = 'DarkGray', bg = 'NONE', ctermbg = 'NONE' })
		override_hl(0, 'VertSplit', { link = 'WinSeparator' })
		override_hl(0, 'Cursor', { bg = 'LightGreen' })
		if _G.kjuq.colorscheme_transparent == nil and true or _G.kjuq.colorscheme_transparent then
			override_hl(0, 'Normal', { bg = 'NONE', ctermbg = 'NONE' })
			override_hl(0, 'Pmenu', { bg = 'NONE', ctermbg = 'NONE' })
			override_hl(0, 'PmenuBorder', { bg = 'NONE', ctermbg = 'NONE' })
			override_hl(0, 'PmenuKind', { bg = 'NONE', ctermbg = 'NONE' })
		end
	end
end

-- `vim.cmd.highlight` is the simplest way to override highlight groups but it is slow and flick color
-- when launching Neovim. That is the reason way I prefer `vim.api.nvim_set_hl`
vim.api.nvim_create_autocmd({ 'ColorScheme' }, {
	group = vim.api.nvim_create_augroup('kjuq_override_colorscheme', {}),
	callback = preference,
})

-- load built-in colorscheme if no colorscheme is loaded by plugin manager
if vim.g.colors_name == nil then
	vim.cmd.colorscheme(_G.kjuq.colorscheme or 'retrobox') -- 'default'|'slate'|'habamax'|'retrobox'|'sorbet'|'unokai'
else
	preference()
end
