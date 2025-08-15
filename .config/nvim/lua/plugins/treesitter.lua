-- Do `:TSInstall all` manually
-- rust and scala take much time to install

---@type LazySpec
local spec = { 'https://github.com/nvim-treesitter/nvim-treesitter' }
spec.branch = 'main'
spec.build = ':TSUpdate'

spec.event = 'VeryLazy'

spec.opts = {
	install_dir = vim.fn.stdpath('data') .. '/site',
}

spec.config = function(_, opts)
	local ts = require('nvim-treesitter')
	ts.setup(opts)
	vim.api.nvim_create_autocmd({ 'FileType' }, {
		group = vim.api.nvim_create_augroup('kjuq_treesitter_start', {}),
		callback = function(args)
			local ft = vim.bo[args.buf].ft
			local lang = vim.treesitter.language.get_lang(ft)
			local installed = require('nvim-treesitter.config').get_installed
			local function enable()
				vim.treesitter.start(args.buf)
				vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
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
		end,
	})
	-- for lazy loading
	vim.bo.filetype = vim.bo.filetype
end

return spec
