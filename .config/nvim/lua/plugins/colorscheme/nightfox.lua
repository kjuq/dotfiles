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
end

return spec
