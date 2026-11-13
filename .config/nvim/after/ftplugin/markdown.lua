-- link highlight groups as a fallback. These does not overwrite existing hlgroup because it is not `highlight!`
-- These combinations are referred to [catppuccin](https://github.com/catppuccin/nvim)

if _G.kjuq_already_set_markdown_header_highlight_group then
	return
end

if vim.tbl_isempty(vim.api.nvim_get_hl(0, { name = '@markup.heading.1' })) then
	vim.cmd([[highlight link @markup.heading.1 Error]])
	vim.api.nvim_set_hl(
		0,
		'@markup.heading.1',
		{ update = true, reverse = false, bg = 'NONE', ctermbg = 'NONE', bold = true }
	)
end

if vim.tbl_isempty(vim.api.nvim_get_hl(0, { name = '@markup.heading.2' })) then
	vim.cmd([[highlight link @markup.heading.2 Constant]])
	vim.api.nvim_set_hl(
		0,
		'@markup.heading.2',
		{ update = true, reverse = false, bg = 'NONE', ctermbg = 'NONE', bold = true }
	)
end

if vim.tbl_isempty(vim.api.nvim_get_hl(0, { name = '@markup.heading.3' })) then
	vim.cmd([[highlight link @markup.heading.3 Structure]])
	vim.api.nvim_set_hl(
		0,
		'@markup.heading.3',
		{ update = true, reverse = false, bg = 'NONE', ctermbg = 'NONE', bold = true }
	)
end

if vim.tbl_isempty(vim.api.nvim_get_hl(0, { name = '@markup.heading.4' })) then
	vim.cmd([[highlight link @markup.heading.4 Added]])
	vim.api.nvim_set_hl(
		0,
		'@markup.heading.4',
		{ update = true, reverse = false, bg = 'NONE', ctermbg = 'NONE', bold = true }
	)
end

if vim.tbl_isempty(vim.api.nvim_get_hl(0, { name = '@markup.heading.5' })) then
	vim.cmd([[highlight link @markup.heading.5 Label]])
	vim.api.nvim_set_hl(
		0,
		'@markup.heading.5',
		{ update = true, reverse = false, bg = 'NONE', ctermbg = 'NONE', bold = true }
	)
end

if vim.tbl_isempty(vim.api.nvim_get_hl(0, { name = '@markup.heading.6' })) then
	vim.cmd([[highlight link @markup.heading.6 Tag]])
	vim.api.nvim_set_hl(
		0,
		'@markup.heading.6',
		{ update = true, reverse = false, bg = 'NONE', ctermbg = 'NONE', bold = true }
	)
end

_G.kjuq_already_set_markdown_header_highlight_group = true
