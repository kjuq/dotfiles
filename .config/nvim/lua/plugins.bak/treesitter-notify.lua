---@type LazySpec
local spec = { "kjuq/treesitter-notify.nvim" }
spec.event = require("utils.lazy").verylazy

spec.opts = {
	blacklist = { "aerial" },
}

return spec
