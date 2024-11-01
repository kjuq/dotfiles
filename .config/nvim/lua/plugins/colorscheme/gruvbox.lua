---@type LazySpec
local spec = { 'ellisonleao/gruvbox.nvim' }
spec.lazy = false
spec.priority = 9999

spec.config = function()
	require('gruvbox').setup({
		transparent_mode = true,
		dim_inactive = false,
	})
	vim.cmd.colorscheme('gruvbox')
	vim.api.nvim_set_hl(0, 'statusline', { bg = 'NONE' })
end

return spec
