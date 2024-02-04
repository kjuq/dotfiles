local map = require("utils.lazy").generate_map("", "Op-camelize: ")

---@type LazySpec
local spec = {
	"tyru/operator-camelize.vim",
	keys = {
		map("gC", "", function() require("utils.common").feed_plug("operator-camelize") end, "Camelize"),
		map("gB", "", function() require("utils.common").feed_plug("operator-decamelize") end, "Decamelize"),
	},
	dependencies = {
		"kana/vim-operator-user",
	},
}

return spec
