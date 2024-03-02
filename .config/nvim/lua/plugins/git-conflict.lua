local map = require("utils.lazy").generate_map("<leader>g", "Git-conflict: ")

---@type LazySpec
local spec = { "akinsho/git-conflict.nvim" }
spec.version = "*"
spec.event = { "BufReadPost" }

spec.opts = {}

return spec
