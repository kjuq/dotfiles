-- https://nanotipsforvim.prose.sh/automatically-set-the-cwd-without-rooter-plugin

vim.api.nvim_create_autocmd({ 'BufEnter' }, {
	group = vim.api.nvim_create_augroup('kjuq_autocd_project', {}),
	callback = function(ctx)
		local patterns = {
			'.git',
			'Makefile',
		}
		local root = vim.fs.root(ctx.buf, patterns)
		if root then
			vim.fn.chdir(root)
		end
	end,
})
