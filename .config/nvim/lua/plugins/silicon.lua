local map = require("utils.lazy").generate_map("<leader>a", "Silicon: ")

---@type LazySpec
local spec = {
	"segeljakt/vim-silicon",
	cmd = "Silicon",
	keys = {
		map("c", "n", function() vim.cmd("Silicon") end, "Capture"),
		map("c", "v", function()
			vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<esc>", true, false, true), "x", false)
			vim.cmd("'<,'>Silicon")
		end, "Capture"),
		map("C", "v", function()
			vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<esc>", true, false, true), "x", false)
			vim.cmd("'<,'>Silicon!")
		end, "Capture with selection highlighted"),
	},
	config = function()
		local store_dir = os.getenv("HOME") .. "/Documents/silicon"

		if vim.fn.isdirectory(store_dir) then
			vim.fn.mkdir(store_dir)
		end

		local datetime = os.date("%Y-%m-%d_%H-%M-%S")

		local v_true = 1
		local v_false = 0

		vim.g.silicon = {
			["theme"] = "Dracula",
			["font"] = "Hack",
			["background"] = "#AAAAFF",
			["shadow-color"] = "#555555",
			["line-pad"] = 2,
			["pad-horiz"] = 80,
			["pad-vert"] = 100,
			["shadow-blur-radius"] = 0,
			["shadow-offset-x"] = 0,
			["shadow-offset-y"] = 0,
			["line-number"] = v_false,
			["round-corner"] = v_true,
			["window-controls"] = v_true,
			["output"] = store_dir .. "/silicon-" .. datetime .. ".png",
		}
	end,
}

return spec
