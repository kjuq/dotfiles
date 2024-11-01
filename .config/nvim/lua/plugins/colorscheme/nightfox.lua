---@type LazySpec
local spec = { 'EdenEast/nightfox.nvim' }
spec.lazy = false
spec.priority = 9999

spec.config = function()
	require('nightfox').setup({
		options = {
			transparent = true, -- imperfect
			dim_inactive = false, -- Non focused panes set to alternative background
		},
	})
	vim.cmd.colorscheme('nightfox')
	vim.api.nvim_set_hl(0, 'WinSeparator', { fg = 'DarkGray' })
	vim.api.nvim_set_hl(0, 'StatusLine', { bg = 'NONE', ctermbg = 'NONE' })
	vim.api.nvim_set_hl(0, 'StatusLineNC', { bg = 'NONE', ctermbg = 'NONE' })
end

return spec
