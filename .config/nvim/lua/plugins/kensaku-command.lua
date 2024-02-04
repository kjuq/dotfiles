local map = require("utils.lazy").generate_map("", "Kensaku-search: ")

---@type LazySpec
local spec = {
	"lambdalisue/kensaku-search.vim",
	keys = {
		map("<C-s>", "c", function()
			require("utils.common").feed_plug("kensaku-search-replace")
		end, "Confirm"),
	},
	dependencies = {
		"vim-denops/denops.vim",
		"lambdalisue/kensaku.vim",
	},
}

return spec
