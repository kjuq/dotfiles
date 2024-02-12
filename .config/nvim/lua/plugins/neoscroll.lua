local map = require("utils.lazy").generate_map("", "Neoscroll: ")

local duration = 150

---@type LazySpec
local spec = { "karb94/neoscroll.nvim" }

spec.keys = {

	map("<C-u>", { "n", "x" }, function()
		if require("utils.lazy").floatscrollup == "<C-u>" and
			pcall(require, "noice") and require("noice.lsp").scroll(-4) then
			return
		end
		require("neoscroll").scroll(-vim.wo.scroll, true, duration)
	end, "Half up"),

	map("<C-d>", { "n", "x" }, function()
		if require("utils.lazy").floatscrolldown == "<C-d>" and
			pcall(require, "noice") and require("noice.lsp").scroll(4) then
			return
		end
		require("neoscroll").scroll(vim.wo.scroll, true, duration)
	end, "Half down"),

	map("<C-b>", { "n", "x" }, function()
		if require("utils.lazy").floatscrollup == "<C-b>" and
			pcall(require, "noice") and require("noice.lsp").scroll(-4) then
			return
		end
		require("neoscroll").scroll(-vim.api.nvim_win_get_height(0), true, duration * 2)
	end, "Up"),

	map("<C-f>", { "n", "x" }, function()
		if require("utils.lazy").floatscrolldown == "<C-f>" and
			pcall(require, "noice") and require("noice.lsp").scroll(4) then
			return
		end
		require("neoscroll").scroll(vim.api.nvim_win_get_height(0), true, duration * 2)
	end, "Down"),

	map("zt", { "n", "x" }, function() require("neoscroll").zt(duration * 0.75) end, "Top this line"),
	map("zz", { "n", "x" }, function() require("neoscroll").zz(duration * 0.75) end, "Center this line"),
	map("zb", { "n", "x" }, function() require("neoscroll").zb(duration * 0.75) end, "Bottom this line"),

}

spec.opts = {
	mappings = {},
	hide_cursor = false,
}

return spec
