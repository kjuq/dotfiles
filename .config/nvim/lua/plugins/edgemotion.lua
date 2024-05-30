local map = require("utils.lazy").generate_map("", "Edgemotion: ")

---@type LazySpec
local spec = { "haya14busa/vim-edgemotion" }

spec.keys = {
	map("<M-j>", { "n", "x" }, "<Plug>(edgemotion-j)", "Down"),
	map("<M-k>", { "n", "x" }, "<Plug>(edgemotion-k)", "Up"),
}

return spec
