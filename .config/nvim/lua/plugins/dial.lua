local map = require("utils.lazy").generate_map("", "Dial: ")

---@type LazySpec
local spec = { "monaqa/dial.nvim" }

spec.keys = {
	map("<C-a>", { "n", "v" }, "<Plug>(dial-increment)", "Increment"),
	map("<C-x>", { "n", "v" }, "<Plug>(dial-decrement)", "Decrement"),
	map("g<C-a>", { "n", "v" }, "g<Plug>(dial-increment)", "G Increment", { remap = true }),
	map("g<C-x>", { "n", "v" }, "g<Plug>(dial-decrement)", "G Decrement", { remap = true }),
}

return spec
