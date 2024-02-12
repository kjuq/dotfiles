local map = require("utils.lazy").generate_map("", "Bufdelete: ")

---@type LazySpec
local spec = { "famiu/bufdelete.nvim" }
spec.cmd = { "Bdelete", "Bwipeout" }

spec.keys = {
	map("gl", "n", function() require("bufdelete").bufdelete(0, false) end, "Delete buffer"),
	map("<leader>x", "n", function() require("bufdelete").bufdelete(0, false) end, "Delete buffer"),
	map("gL", "n", function() require("bufdelete").bufdelete(0, true) end, "Delete buffer forcibly"),
	map("<leader>X", "n", function() require("bufdelete").bufdelete(0, true) end, "Delete buffer forcibly"),
}

return spec
