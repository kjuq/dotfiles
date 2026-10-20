-- Do `:TSInstall all` manually
-- rust and scala take much time to install

vim.pack.add({ 'https://github.com/nvim-treesitter/nvim-treesitter' })

local is_first = true

require('nvim-treesitter').setup({
	install_dir = vim.fn.stdpath('data') .. '/site',
})

local start = function(args)
	local ft = vim.bo[args.buf].ft
	local lang = vim.treesitter.language.get_lang(ft)
	if
		not vim.tbl_contains(require('nvim-treesitter').get_installed(), lang)
		and vim.tbl_contains(require('nvim-treesitter').get_available(), lang)
	then
		require('nvim-treesitter').install({ lang }):await(function(err)
			if err then
				vim.notify('Treesitter install error\nft: ' .. ft .. '\nerr: ' .. err, vim.log.level.error)
				return
			end
		end)
	end
	if vim.tbl_contains(require('nvim-treesitter').get_installed(), lang) then
		vim.treesitter.start(args.buf)
		if not lang == 'python' then
			vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		end
	end
end

vim.api.nvim_create_autocmd({ 'FileType' }, {
	group = vim.api.nvim_create_augroup('kjuq_treesitter_start', {}),
	callback = start,
})

if is_first then
	start({ buf = 0 })
end

is_first = false
