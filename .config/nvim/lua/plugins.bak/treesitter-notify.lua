---@type LazySpec
local spec = { "kjuq/treesitter-notify.nvim" }
spec.event = "VeryLazy"

spec.opts = {
	blacklist = { "aerial" },
}

return spec
