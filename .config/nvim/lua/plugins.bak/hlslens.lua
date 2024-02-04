local map = require("utils.lazy").generate_map("", "Hlslens: ")

local rhs = function(key)
	return function()
		vim.api.nvim_feedkeys(vim.v.count1 .. key, "n", false)
		require("hlslens").start()
	end
end

return {
	"kevinhwang91/nvim-hlslens",
	event = { "CmdlineEnter" },
	keys = {
		map("n", "n", rhs("n"), "Next matched word"),
		map("N", "n", rhs("N"), "Previous matched word"),
		map("*", "n", rhs("*"), "Search forward current word"),
		map("#", "n", rhs("#"), "Search backward current word"),
		map("g*", "n", rhs("g*"), "* without \"\\<\" and \"\\>\""),
		map("g#", "n", rhs("g*"), "# without \"\\<\" and \"\\>\""),
	},
	opts = {},
}
