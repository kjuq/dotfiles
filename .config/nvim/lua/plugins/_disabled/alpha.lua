---@type LazySpec
local spec = { 'goolord/alpha-nvim' }
spec.lazy = vim.fn.argc() > 0

spec.cmd = 'Alpha'

spec.opts = function()
	return require('alpha.themes.startify').config
end

spec.specs = {
	'nvim-tree/nvim-web-devicons',
	'nvim-lua/plenary.nvim',
}

return spec
