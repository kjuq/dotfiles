-- https://nanotipsforvim.prose.sh/automatically-set-the-cwd-without-rooter-plugin

---@param bufnr? integer
local function cdroot(bufnr)
	vim.print(bufnr)
	if not bufnr then
		bufnr = 0
	end
	local patterns = {
		'.git',
		'Makefile',
	}
	local root = vim.fs.root(bufnr, patterns)
	if root then
		vim.fn.chdir(root)
	end
end
vim.api.nvim_create_user_command('Cdroot', function()
	cdroot(0)
end, {})

vim.api.nvim_create_autocmd({ 'BufEnter' }, {
	group = vim.api.nvim_create_augroup('kjuq_autocd_project', {}),
	command = 'Cdroot',
})
