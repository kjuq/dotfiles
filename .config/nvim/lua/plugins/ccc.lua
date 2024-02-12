local map = require("utils.lazy").generate_cmd_map("<leader>a", "CCC: ")

---@type LazySpec
local spec = { "uga-rosa/ccc.nvim" }
spec.event = require("utils.lazy").verylazy

spec.keys = {
	map("r", "n", "CccPick", "Open picker"),
}

spec.config = function()
	require("ccc").setup {
		highlighter = {
			auto_enable = true,
		},
	}
	vim.cmd("CccHighlighterEnable") -- for lazy load
end

return spec
