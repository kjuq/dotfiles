---@type LazySpec
local spec = { 'https://github.com/ellisonleao/gruvbox.nvim' }
spec.lazy = _G.kjuq_colorscheme ~= 'gruvbox'
spec.priority = 9999

spec.opts = {
	transparent_mode = _G.kjuq_colorscheme_transparent == nil and true or _G.kjuq_colorscheme_transparent,
	dim_inactive = false,
}

spec.config = function(_, opts)
	require('gruvbox').setup(opts)
	vim.cmd.colorscheme(_G.kjuq_colorscheme)
end

return spec
