---@type LazySpec
local spec = { "anuvyklack/help-vsplit.nvim" }
spec.keys = { { "h", mode = "c" }, }
spec.ft = { "TelescopePrompt", }

spec.opts = { side = "right", }

return spec
