local map = require("utils.lazy").generate_map("", "Neoscroll: ")
local nx = { "n", "x" }

local duration = 150

---@type LazySpec
local spec = { "karb94/neoscroll.nvim" }

spec.keys = {
	map("<C-u>", nx, function()
		if not (pcall(require, "noice") and require("noice.lsp").scroll(-4)) then
			require("neoscroll").scroll(-vim.wo.scroll, true, duration)
		end
	end, "Half up"),
	map("<C-d>", nx, function()
		if not (pcall(require, "noice") and require("noice.lsp").scroll(4)) then
			require("neoscroll").scroll(vim.wo.scroll, true, duration)
		end
	end, "Half down"),
	map("<C-b>", nx, function()
		require("neoscroll").scroll(-vim.api.nvim_win_get_height(0), true, duration * 2)
	end, "Up"),
	map("<C-f>", nx, function()
		require("neoscroll").scroll(vim.api.nvim_win_get_height(0), true, duration * 2)
	end, "Down"),
	map("zt", nx, function() require("neoscroll").zt(duration * 0.75) end, "Top this line"),
	map("zz", nx, function() require("neoscroll").zz(duration * 0.75) end, "Center this line"),
	map("zb", nx, function() require("neoscroll").zb(duration * 0.75) end, "Bottom this line"),
}

spec.opts = {
	mappings = {},
	hide_cursor = false,
}

return spec
