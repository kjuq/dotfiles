local settings = {
	Lua = {
		runtime = {
			version = 'LuaJIT',
			pathStrict = true,
			-- path = { "?.lua", "?/init.lua" },
		},
		format = { enable = false }, -- Use StyLua if disabled
		hint = { enable = true },
		diagnostics = {
			-- NOTE: Make sure to `luacheck` is NOT installed to any paths
			enable = true,
			disable = {
				'unused-function', -- avoid dimmed contents of functions (hard to read (!!))
			},
		},
	},
}

---@type vim.lsp.Config
return {
	settings = settings,
}
