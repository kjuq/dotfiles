local map = require("utils.lazy").generate_map("<leader>a", "CCC: ")

---@type LazySpec
local spec = { "uga-rosa/ccc.nvim" }
spec.event = require("utils.lazy").verylazy

spec.keys = {
	map("r", "n", "<CMD>CccPick<CR>", "Open picker"),
}

spec.opts = {
	highlighter = {
		-- auto_enable = true,
	},
}

spec.config = function()
	require("ccc").setup(spec.opts)

	local max_lines = 30000

	local enable_hl = function()
		if vim.fn.line("$") <= max_lines then
			vim.cmd("CccHighlighterEnable")
		end
	end

	enable_hl()

	vim.api.nvim_create_autocmd({ "BufEnter" }, {
		group = vim.api.nvim_create_augroup("user_ccc_highlighter_auto_enable", {}),
		callback = enable_hl,
	})
end

return spec
