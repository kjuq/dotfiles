---@module 'lazy'
---@type LazySpec
local spec = { 'https://github.com/kjuq/treesitter-notify.nvim' }
spec.event = 'VeryLazy'

spec.opts = {
	blacklist = { 'aerial' },
}

return spec
