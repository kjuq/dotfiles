---@type LazySpec
local spec = { 'https://github.com/folke/persistence.nvim' }
spec.event = 'VeryLazy'

local map = require('kjuq.utils.lazy').generate_map('<Space>r', 'Persistence: ')
spec.keys = {
	map('s', 'n', function()
		require('persistence').load()
	end, 'Restore session for the current dir'),
	map('l', 'n', function()
		require('persistence').load({ last = true })
	end, 'Restore the last session'),
	map('p', 'n', function()
		require('persistence').select()
	end, 'Pick a session to load'),
	map('d', 'n', function()
		require('persistence').stop()
	end, 'Stop saving session on exit'),
}

spec.opts = {}

spec.config = function(_, opts)
	local dir_bak
	vim.api.nvim_create_autocmd({ 'User' }, {
		pattern = 'PersistenceSavePre',
		group = vim.api.nvim_create_augroup('kjuq_persistence_save_pre', {}),
		callback = function()
			dir_bak = vim.fn.getcwd()
			if _G.kjuq_init_cwd then
				vim.fn.chdir(_G.kjuq_init_cwd)
			end
		end,
	})
	vim.api.nvim_create_autocmd({ 'User' }, {
		pattern = 'PersistenceSavePost',
		group = vim.api.nvim_create_augroup('kjuq_persistence_save_post', {}),
		callback = function()
			vim.fn.chdir(dir_bak)
		end,
	})

	require('persistence').setup(opts)

	-- -- Restore session for cwd if `nvim` was launched without any arguments
	-- local common = require('utils.common')
	-- local empty_buffer = common.is_empty_buffer()
	-- local cur_file_not_exists = not common.is_current_file_exists()
	-- local no_args = #vim.fn.argv() == 0
	-- local empty_bufname = vim.api.nvim_buf_get_name(0) == ''
	-- local load_session = empty_buffer and cur_file_not_exists and no_args and empty_bufname
	-- if load_session then
	-- 	vim.schedule(function()
	-- 		require('persistence').load()
	-- 	end)
	-- end
end

return spec
