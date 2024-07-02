---@type LazySpec
local spec = { "j-hui/fidget.nvim" }
spec.event = { "LspAttach", "VeryLazy" }

local map = require("utils.lazy").generate_map("", "Fidget: ")
spec.keys = {
	map("<leader>aa", "n", "<Cmd>Fidget history<CR>", "History"),
}

spec.opts = {
	notification = {
		filter = vim.log.levels.TRACE,
		override_vim_notify = true,
	},
}

return spec
