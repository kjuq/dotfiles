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
			disable = {
				'unused-function', -- avoid dimmed contents of functions (hard to read (!!))
			},
		},
	},
}

return {
	cmd = { 'lua-language-server' },
	root_markers = { '.luarc.json' },
	filetypes = { 'lua' },
	settings = settings,
}

