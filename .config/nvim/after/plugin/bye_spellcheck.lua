local spell = vim.o.spell
vim.api.nvim_create_autocmd({ 'FileType' }, {
	pattern = 'mail',
	group = vim.api.nvim_create_augroup('kjuq_bye_spellcheck', {}),
	callback = function()
		vim.wo.spell = spell
	end,
})
