---@type LazySpec
local spec = { 'folke/lazydev.nvim' }

spec.event = 'VeryLazy'

spec.opts = {
	library = {
		'lazy.nvim',
		{ path = 'luvit-meta/library', words = { 'vim%.uv' } },
	},
}

spec.config = function(_, opts)
	local group = vim.api.nvim_create_augroup('user_lazyload_lazydev', {})

	vim.api.nvim_create_autocmd({ 'FileType' }, {
		pattern = 'lua',
		group = group,
		callback = function()
			require('lazydev').setup(opts)
		end,
		once = true,
	})

	vim.api.nvim_exec_autocmds('FileType', { pattern = vim.o.filetype })

	local cmp_init = function()
		require('cmp').setup({
			name = 'lazydev',
			group_index = 0, -- set group index to 0 to skip loading LuaLS completions
		})
	end

	local callback = function(ev)
		local plugname = ev.data
		if plugname == 'nvim-cmp' then
			cmp_init()
		end
	end

	-- To load cmp lazily, not using `spec.dependencies`
	vim.api.nvim_create_autocmd({ 'User' }, {
		pattern = 'LazyLoad',
		group = group,
		callback = callback,
	})
end

spec.dependencies = {
	'Bilal2453/luvit-meta', -- optional `vim.uv` typings
}

return spec
