-- This plugin takes much time to be loaded. So I recommend to load lazily somehow

---@type LazySpec
local spec = { 'OXY2DEV/markview.nvim' }

spec.cmd = 'Markview'

spec.opts = {
	preview = {
		enable = false,
	},
}

local map = require('kjuq.utils.lazy').generate_map('', 'Markview: ')
spec.keys = {
	map('<Space>ap', 'n', '<Cmd>Markview toggle<CR>', 'Toggle', { ft = 'markdown' }),
}

spec.config = function(_, opts)
	local mv = require('markview')
	mv.setup(opts)

	-- for lazy load
	-- mv.commands.attach()
	-- NOTE: Use this method once it is fixed that `nvim_exec_autocmds` takes `pattern` and `buffer` at the same time
	for _, winid in ipairs(vim.api.nvim_list_wins()) do
		local bufnr = vim.api.nvim_win_get_buf(winid)
		if vim.bo[bufnr].filetype == 'markdown' then
			mv.commands.attach(bufnr)
		end
	end
end

spec.specs = {
	'nvim-treesitter/nvim-treesitter',
	'nvim-tree/nvim-web-devicons',
}

return spec
