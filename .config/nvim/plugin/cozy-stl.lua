local statusline_bak = vim.o.statusline
local fillchars_bak = vim.o.fillchars

local clean = function()
	vim.opt.statusline = '─'
	-- Setting all window-local options is necessary to avoid unexpected behavior with lualine enabled
	-- `<C-w><C-v><C-w><C-s><C-w><C-w>gas`
	for _, winid in ipairs(vim.api.nvim_list_wins()) do
		vim.wo[winid].statusline = '─'
	end
	vim.cmd.set('fillchars+=stl:─,stlnc:─,vert:│')
	vim.api.nvim_set_hl(0, 'StatusLine', { link = 'VertSplit', force = true })
	vim.api.nvim_set_hl(0, 'StatusLineNC', { link = 'VertSplit', force = true })
end

local restore = function()
	vim.opt.statusline = statusline_bak
	for _, winid in ipairs(vim.api.nvim_list_wins()) do
		vim.wo[winid].statusline = statusline_bak
	end
	vim.opt.fillchars = fillchars_bak
	vim.cmd([[highlight clear StatusLine]])
	vim.cmd([[highlight clear StatusLineNC]])
end

local cb = function()
	if vim.o.laststatus == 0 then
		clean()
	else
		restore()
	end
end

vim.api.nvim_create_autocmd({ 'OptionSet' }, {
	pattern = 'laststatus',
	group = vim.api.nvim_create_augroup('kjuq_cozy_statusline_optset', {}),
	callback = cb,
})

vim.api.nvim_create_autocmd({ 'VimEnter' }, {
	group = vim.api.nvim_create_augroup('kjuq_cozy_statusline_enter', {}),
	callback = cb,
	once = true,
})
