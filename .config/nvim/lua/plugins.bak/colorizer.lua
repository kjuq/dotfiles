---@type LazySpec
local spec = {
	"norcalli/nvim-colorizer.lua",
	event = require("utils.lazy").verylazy,
	config = function() -- `opts` not works
		require("colorizer").setup()
		vim.cmd("ColorizerAttachToBuffer")
	end,
}

return spec
