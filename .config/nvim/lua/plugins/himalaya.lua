local map = require("utils.lazy").generate_cmd_map("<leader>a", "Himalaya: ")

---@type LazySpec
local spec = {
	"https://git.sr.ht/~soywod/himalaya-vim",
	commit = "64fb17067cf5dbf5349726b9ed1b1b38065cdb82",
	cmd = "Himalaya",
	keys = {
		map("h", "n", "Himalaya", "Open"),
	},
}

return spec
