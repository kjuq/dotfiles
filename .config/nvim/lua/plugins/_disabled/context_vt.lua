---@module 'lazy'
---@type LazySpec
local spec = { 'https://github.com/andersevenrud/nvim_context_vt' }
spec.event = 'VeryLazy'

spec.opts = {
	prefix = ' -->',
	disable_virtual_lines = true,
}

return spec
