---@type LazySpec
local spec = { 'goolord/alpha-nvim' }
spec.cond = vim.fn.argc() == 0 -- if nvim was launched without files specified by args
spec.lazy = false
-- spec.event = { 'BufWinEnter' }

spec.opts = function()
	return require('alpha.themes.startify').config
end

spec.specs = {
	'nvim-tree/nvim-web-devicons',
	'nvim-lua/plenary.nvim',
}

return spec
