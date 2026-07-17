---@module 'lazy'
---@type LazySpec
local spec = { 'https://github.com/EdenEast/nightfox.nvim' }
spec.lazy = false
spec.priority = 9999

spec.opts = {
	options = {
		transparent = _G.kjuq.colorscheme_transparent == nil and true or _G.kjuq.colorscheme_transparent,
		dim_inactive = false, -- Non focused panes set to alternative background
	},
}

spec.config = function(_, opts)
	require('nightfox').setup(opts) -- `setup` must be called before loading
	vim.cmd.colorscheme('nightfox')
end

return spec
