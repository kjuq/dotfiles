local map = require("utils.lazy").generate_map("", "Edgemotion: ")

---@type LazySpec
local spec = { "haya14busa/vim-edgemotion" }

spec.keys = {
	map("<M-j>", "n", "<Plug>(edgemotion-j)", "Down"),
	map("<M-k>", "n", "<Plug>(edgemotion-k)", "Up"),
}

return spec
