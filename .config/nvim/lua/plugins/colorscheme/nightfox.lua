---@type LazySpec
local spec = { 'EdenEast/nightfox.nvim' }
spec.lazy = _G.kjuq_colorscheme ~= 'nightfox'
spec.priority = 9999

spec.opts = {
	options = {
		transparent = _G.kjuq_colorscheme_transparent == nil and true or _G.kjuq_colorscheme_transparent,
		dim_inactive = false, -- Non focused panes set to alternative background
	},
}

spec.config = function(_, opts)
	require('nightfox').setup(opts)
	vim.cmd.colorscheme(_G.kjuq_colorscheme)
end

return spec
