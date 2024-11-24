-- This plugin takes much time to be loaded. So I recommend to load lazily somehow

---@type LazySpec
local spec = { 'OXY2DEV/markview.nvim' }

spec.cmd = 'Markview'

local toggle_enabled = false
local toggle = function()
	local mvc = require('markview').commands
	if toggle_enabled then
		-- I don't know why but disableAll is necessary to toggle flowlessly with one keymap
		mvc.disableAll()
		mvc.splitToggle()
	else
		mvc.splitToggle()
	end
	toggle_enabled = not toggle_enabled
end

local map = require('utils.lazy').generate_map('', 'Markview: ')
spec.keys = {
	map('K', 'n', toggle, 'Toggle split', { ft = 'markdown' }),
}

spec.opts = {
	initial_state = false,
}

spec.config = function(_, opts)
	local mv = require('markview')
	mv.setup(opts)

	-- for lazy load
	mv.commands.attach()
	-- NOTE: Use this method once it is fixed that `nvim_exec_autocmds` takes `pattern` and `buffer` at the same time
	-- for _, winid in ipairs(vim.api.nvim_list_wins()) do
	-- 	local bufnr = vim.api.nvim_win_get_buf(winid)
	-- 	if vim.bo[bufnr].filetype == 'markdown' then
	-- 		mv.commands.attach(bufnr)
	-- 	end
	-- end
end

spec.specs = {
	'nvim-treesitter/nvim-treesitter',
	'nvim-tree/nvim-web-devicons',
}

return spec
