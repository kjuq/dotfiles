-- This plugin takes much time to be loaded. So I recommend to load lazily somehow

---@module 'lazy'
---@type LazySpec
local spec = { 'https://github.com/OXY2DEV/markview.nvim' }

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
