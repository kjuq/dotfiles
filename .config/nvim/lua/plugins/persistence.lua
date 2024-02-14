local map = require("utils.lazy").generate_map("<leader>r", "Persistence: ")

---@type LazySpec
local spec = { "folke/persistence.nvim" }
spec.event = "BufReadPre" -- this will only start session saving when an actual file was opened

spec.keys = {
	-- restore the session for the current directory
	map("s", "n", function()
		require("persistence").load()
	end, "Restore session for the current dir"),
	-- restore the last session
	map("l", "n", function()
		require("persistence").load({ last = true })
	end, "Restore the last session"),
	-- stop Persistence => session won't be saved on exit
	map("d", "n", function()
		require("persistence").stop()
	end, "Stop saving session on exit"),
}

spec.opts = {}

return spec
