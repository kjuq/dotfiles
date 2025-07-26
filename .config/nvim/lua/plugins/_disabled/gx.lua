---@type LazySpec
local spec = { 'https://github.com/chrishrb/gx.nvim' }
spec.keys = { { 'gx', '<cmd>Browse<cr>', mode = { 'n', 'x' } } }
spec.cmd = { 'Browse' }

spec.init = function()
	vim.g.netrw_nogx = 1
end

spec.opts = {}

spec.specs = { 'nvim-lua/plenary.nvim' }

return spec
