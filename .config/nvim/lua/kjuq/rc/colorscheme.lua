vim.api.nvim_create_autocmd({ 'ColorScheme' }, {
	group = vim.api.nvim_create_augroup('kjuq_override_colorscheme', {}),
	callback = function()
		if vim.o.background == 'light' then
			require('kjuq.utils.colorscheme').override.light()
		elseif vim.o.background == 'dark' then
			require('kjuq.utils.colorscheme').override.dark()
		end
	end,
})

-- load built-in colorscheme if no colorscheme is loaded by plugin manager
if vim.g.colors_name == nil then
	-- vim.cmd.colorscheme('default')
	-- vim.cmd.colorscheme('habamax')
	-- vim.cmd.colorscheme('retrobox')
	vim.cmd.colorscheme('slate')
	-- vim.cmd.colorscheme('sorbet')
	-- vim.cmd.colorscheme('unokai')
	---@diagnostic disable-next-line: undefined-field
	require('kjuq.utils.colorscheme').make_transparent(_G.kjuq_colorscheme_transparent)
end
