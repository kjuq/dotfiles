---@type LazySpec
local spec = { "akinsho/git-conflict.nvim" }
spec.version = "*"
spec.event = { "BufReadPost" }

spec.opts = {}

return spec
