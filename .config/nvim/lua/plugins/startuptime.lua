local map = require("utils.lazy").generate_cmd_map("<leader>", "Startuptime: ")

---@type LazySpec
local spec = { "dstein64/vim-startuptime" }
spec.cmd = { "StartupTime" }

spec.keys = {
	map("av", "n", "StartupTime", "Calculate the time")
}

spec.config = function()
	vim.g.startuptime_tries = 10
end

return spec
