---@type LazySpec
local spec = { "gbprod/substitute.nvim" }

local map = require("utils.lazy").generate_map("", "Substitute: ")
spec.keys = {
	map("s", "n", function()
		require("substitute").operator()
	end, "Start"),
	map("ss", "n", function()
		require("substitute").line()
	end, "Line"),
	map("S", "n", function()
		require("substitute").eol()
	end, "Till end of line"),
	map("s", "x", function()
		require("substitute").visual()
	end, "Visual"),
}

spec.opts = {}

return spec
