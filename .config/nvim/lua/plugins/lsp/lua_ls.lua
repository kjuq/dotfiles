local M = {}

M.opts = {
	settings = {
		Lua = {
			runtime = {
				version = 'LuaJIT',
				pathStrict = true,
				-- path = { "?.lua", "?/init.lua" },
			},
			format = { enable = false }, -- Use StyLua if disabled
			hint = { enable = true },
		},
	},
}

return M

-- The setup without Lazydev.nvim was removed at 1b9981e1458ef2360dfd38fbdbf033be70379d77
