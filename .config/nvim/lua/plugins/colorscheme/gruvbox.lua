---@type LazySpec
local spec = { 'ellisonleao/gruvbox.nvim' }
spec.lazy = _G.kjuq_colorscheme ~= 'gruvbox'
spec.priority = 9999

spec.opts = {
	transparent_mode = true,
	dim_inactive = false,
}

spec.config = function(_, opts)
	require('gruvbox').setup(opts)
	vim.cmd.colorscheme('gruvbox')
end

return spec
