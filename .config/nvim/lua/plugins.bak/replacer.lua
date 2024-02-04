local map = require("utils.lazy").generate_map("<leader>a", "Replacer: ")

return {
	"gabrielpoca/replacer.nvim",
	keys = {
		map("q", "n", function() require("replacer").run() end, "Run")
	},
}
