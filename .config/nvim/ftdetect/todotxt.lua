vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = { "[Tt]odo.txt", "*.[Tt]odo.txt", "[Dd]one.txt", "*.[Dd]one.txt" },
	group = vim.api.nvim_create_augroup("user_snippets", {}),
	callback = function()
		vim.opt_local.filetype = "todo"
	end,
})
