---@type LazySpec
local spec = { 'EdenEast/nightfox.nvim' }
spec.lazy = _G.kjuq_colorscheme ~= 'nightfox'
spec.priority = 9999

spec.opts = {
	options = {
		transparent = true, -- imperfect
		dim_inactive = false, -- Non focused panes set to alternative background
	},
}

spec.config = function(_, opts)
	require('nightfox').setup(opts)
	vim.cmd.colorscheme('nightfox')
	vim.api.nvim_set_hl(0, 'WinSeparator', { fg = 'DarkGray' })
	vim.api.nvim_set_hl(0, 'StatusLine', { bg = 'NONE', ctermbg = 'NONE' })
	vim.api.nvim_set_hl(0, 'StatusLineNC', { bg = 'NONE', ctermbg = 'NONE' })
end

return spec
