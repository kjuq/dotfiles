local map = require("utils.lazy").generate_map("", "Dial: ")
local dm = "dial.map"

return {
	"monaqa/dial.nvim",
	keys = {
		map("<C-a>", "n", function() require(dm).manipulate("increment", "normal") end, "Increment"),
		map("<C-x>", "n", function() require(dm).manipulate("decrement", "gnormal") end, "Decrement"),
		map("g<C-a>", "n", function() require(dm).manipulate("increment", "normal") end, "G Increment"),
		map("g<C-x>", "n", function() require(dm).manipulate("decrement", "gnormal") end, "G Decrement"),
		map("<C-a>", "v", function() require(dm).manipulate("increment", "visual") end, "Increment"),
		map("<C-x>", "v", function() require(dm).manipulate("decrement", "gvisual") end, "Decrement"),
		map("g<C-a>", "v", function() require(dm).manipulate("increment", "visual") end, "G Increment"),
		map("g<C-x>", "v", function() require(dm).manipulate("decrement", "gvisual") end, "G Decrement"),
	},
}
