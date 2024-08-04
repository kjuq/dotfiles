---@type LazySpec
local spec = { 'goolord/alpha-nvim' }
spec.cond = vim.fn.argc() == 0 -- if nvim was launched without files specified by args
spec.event = { 'BufWinEnter' }

spec.config = function() require('alpha').setup(require('alpha.themes.theta').config) end

spec.dependencies = {
	'nvim-tree/nvim-web-devicons',
}

return spec
