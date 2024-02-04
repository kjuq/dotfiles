local map = require("utils.lazy").generate_cmd_map("", "ToggleTerm: ")

local open_cmd = "ToggleTerm dir=%:p:h"

return {
	"akinsho/toggleterm.nvim",
	version = "*",
	keys = {
		map("<C-space>", { "n" }, open_cmd, "Open")
	},
	cmd = {
		"ToggleTerm",
		"ToggleTermSetName",
		"ToggleTermToggleAll",
		"ToggleTermSendCurrentLine",
		"ToggleTermSendVisualLines",
		"ToggleTermSendVisualSelection",
	},
	opts = function()
		---@diagnostic disable-next-line: duplicate-set-field
		function _G.set_terminal_keymaps()
			local opts = { buffer = 0 }
			-- vim.keymap.set("t", "<esc>", function() vim.cmd(open_cmd) end, opts)
			vim.keymap.set("t", "<C-Space>", function() vim.cmd(open_cmd) end, opts)
		end

		vim.api.nvim_create_autocmd({ "TermOpen" }, {
			pattern = "term://*toggleterm#*",
			callback = function() set_terminal_keymaps() end,
		})

		return {
			direction = "float",
			-- float_opts = { winblend = 20, },
		}
	end
}
