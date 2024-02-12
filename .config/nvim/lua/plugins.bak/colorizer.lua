---@type LazySpec
local spec = { "norcalli/nvim-colorizer.lua" }
spec.event = require("utils.lazy").verylazy

spec.config = function() -- `opts` not works
	require("colorizer").setup()
	vim.cmd("ColorizerAttachToBuffer")
end

return spec
