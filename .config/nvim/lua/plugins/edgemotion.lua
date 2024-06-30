local map = require("utils.lazy").generate_map("", "Edgemotion: ")

---@type LazySpec
local spec = { "haya14busa/vim-edgemotion" }

spec.keys = {
	map("<C-n>", { "n", "x" }, "<Plug>(edgemotion-j)", "Down"),
	map("<C-p>", { "n", "x" }, "<Plug>(edgemotion-k)", "Up"),
}

return spec
