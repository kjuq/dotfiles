local map = require("utils.lazy").generate_map("", "Asterisk: ")

---@type LazySpec
local spec = { "haya14busa/vim-asterisk" }

-- spec.init = function()
-- 	vim.g["asterisk#keeppos"] = 1
-- end

spec.keys = {
	map("*", "n", "<Plug>(asterisk-z*)<CR>", "z*"),
	map("g*", "n", "<Plug>(asterisk-gz*)<CR>", "gz*"),
	map("#", "n", "<Plug>(asterisk-z#)<CR>", "z#"),
	map("g#", "n", "<Plug>(asterisk-gz#)<CR>", "gz#"),
}

return spec
