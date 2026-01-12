-- Do `:TSInstall all` manually
-- rust and scala take much time to install

---@module 'lazy'
---@type LazySpec
local spec = { 'https://github.com/nvim-treesitter/nvim-treesitter' }
spec.branch = 'main'
spec.build = ':TSUpdate'

spec.event = 'VeryLazy'

spec.opts = {
	install_dir = vim.fn.stdpath('data') .. '/site',
}

local is_first = true

spec.config = function(_, opts)
	require('nvim-treesitter').setup(opts)
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
			vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
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
end

return spec
