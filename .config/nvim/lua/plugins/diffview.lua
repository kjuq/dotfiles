local map = require("utils.lazy").generate_cmd_map("<leader>g", "Diffview: ")

---@type LazySpec
local spec = { "sindrets/diffview.nvim" }

spec.cmd = {
	"DiffviewOpen",
	"DiffviewFileHistory",
	"DiffviewClose",
	"DiffviewFocusFiles",
	"DiffviewToggleFiles",
	"DiffviewRefresh",
	"DiffviewLog",
}

spec.keys = {
	map("o", "n", "DiffviewOpen", "Open"),
	map("l", "n", "DiffviewFileHistory %", "File History"),
}

spec.config = function()
	vim.api.nvim_create_autocmd({ "FileType" }, {
		pattern = { "DiffviewFileHistory", "DiffviewFiles" },
		group = vim.api.nvim_create_augroup("user_diff_view", {}),
		callback = function()
			vim.keymap.set("n", "<leader>q", function()
				vim.cmd("DiffviewClose")
			end, { buffer = true })
		end,
	})
end

return spec
