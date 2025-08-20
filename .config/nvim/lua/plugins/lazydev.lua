---@module 'lazy'
---@type LazySpec
local spec = { 'https://github.com/folke/lazydev.nvim' }

spec.cond = not os.getenv('KJUQ_NVIM_LOAD_ALL_RUNTIME_PATH')
spec.event = 'VeryLazy'

spec.opts = {
	library = {
		vim.fs.joinpath(vim.fn.stdpath('config'), '/lua'),
	},
}

spec.config = function(_, opts)
	-- Monkeypatch in a PR to remove a call to the deprecated `client.notify`
	-- https://github.com/folke/lazydev.nvim/pull/106#issuecomment-3192410133
	local lsp = require('lazydev.lsp')
	---@diagnostic disable-next-line: duplicate-set-field
	lsp.update = function(client)
		lsp.assert(client)
		client:notify('workspace/didChangeConfiguration', {
			settings = { Lua = {} },
		})
	end
	local group = vim.api.nvim_create_augroup('kjuq_lazyload_lazydev', {})
	vim.api.nvim_create_autocmd({ 'FileType' }, {
		pattern = 'lua',
		group = group,
		callback = function()
			require('lazydev').setup(opts)
		end,
		once = true,
	})
	vim.api.nvim_exec_autocmds('FileType', { pattern = vim.o.filetype })
	-- To load cmp lazily, not using `spec.dependencies`
	vim.api.nvim_create_autocmd({ 'User' }, {
		pattern = 'LazyLoad',
		group = group,
		callback = function(ev)
			local plugname = ev.data
			if plugname == 'nvim-cmp' then
				require('cmp').setup({
					name = 'lazydev',
					group_index = 0, -- set group index to 0 to skip loading LuaLS completions
				})
			end
		end,
	})
end

spec.dependencies = {
	'williamboman/mason.nvim',
	'neovim/nvim-lspconfig',
}

return spec
