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

local indent_lang = { 'python', 'markdown' }

spec.config = function(_, opts)
	local ts = require('nvim-treesitter')
	ts.setup(opts)
	local callback = function(args)
		local ft = vim.bo[args.buf].ft
		local lang = vim.treesitter.language.get_lang(ft)
		local installed = require('nvim-treesitter.config').get_installed
		local function enable()
			vim.treesitter.start(args.buf)
			if vim.tbl_contains(indent_lang, lang) then
				vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end
		end
		if not vim.tbl_contains(installed(), lang) then
			ts.install({ lang }):await(function(err)
				if err then
					vim.notify('Treesitter install error\nft: ' .. ft .. '\nerr: ' .. err, vim.log.level.error)
					return
				end
				if vim.tbl_contains(installed(), lang) then -- if `lang` was newly installed
					enable()
				end
			end)
			return
		end
		enable() -- if `lang` was already installed
	end
	vim.api.nvim_create_autocmd({ 'FileType' }, {
		group = vim.api.nvim_create_augroup('kjuq_treesitter_start', {}),
		callback = callback,
	})
	-- for lazy loading
	vim.bo.filetype = vim.bo.filetype
end

return spec
