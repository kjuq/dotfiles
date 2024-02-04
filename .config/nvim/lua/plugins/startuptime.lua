local map = require("utils.lazy").generate_cmd_map("<leader>", "Startuptime: ")

---@type LazySpec
local spec = {
	"dstein64/vim-startuptime",
	cmd = { "StartupTime" },
	keys = {
		map("av", "n", "StartupTime", "Calculate the time")
	},
	config = function()
		vim.g.startuptime_tries = 10
	end,
}

return spec
