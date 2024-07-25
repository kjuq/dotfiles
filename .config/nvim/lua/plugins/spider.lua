---@type LazySpec
local spec = { "chrisgrieser/nvim-spider" }

local map = require("utils.lazy").generate_map("", "Spider: ")
spec.keys = {
	map("w", { "n", "x" }, function()
		require("utils.confined-wbege").motion(function()
			require("spider").motion("w")
		end)
	end, "w"),
	map("b", { "n", "x" }, function()
		require("utils.confined-wbege").motion(function()
			require("spider").motion("b")
		end)
	end, "b"),
	map("e", { "n", "x" }, function()
		require("utils.confined-wbege").motion(function()
			require("spider").motion("e")
		end)
	end, "e"),
	map("ge", { "n", "x" }, function()
		require("utils.confined-wbege").motion(function()
			require("spider").motion("ge")
		end)
	end, "ge"),
}

spec.opts = {}

return spec
