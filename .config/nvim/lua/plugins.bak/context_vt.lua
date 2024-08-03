---@type LazySpec
local spec = { "andersevenrud/nvim_context_vt" }
spec.event = "VeryLazy"

spec.opts = {
	prefix = " -->",
	disable_virtual_lines = true,
}

return spec
