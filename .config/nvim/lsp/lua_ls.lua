local settings = {
	Lua = {
		runtime = {
			version = 'LuaJIT',
			pathStrict = true,
			-- path = { '?.lua', '?/init.lua' }, -- same as a default value
		},
		workspace = {
			-- library = vim.api.nvim_get_runtime_file('lua', true), -- does not detect lazy-loaded plugins
			library = {
				vim.fs.joinpath(vim.env.VIMRUNTIME, '/lua'),
				-- vim.fs.joinpath(vim.fn.stdpath('config'), '/lua'), -- NOTE: If `lazydev` is enabled comment-out this
			},
			checkThirdParty = 'disable',
		},
		format = {
			enable = false, -- Use StyLua
		},
		hint = {
			enable = true,
		},
		semantic = {
			annotation = false, -- Use `luadoc` treesitter (https://blog.atusy.net/2025/07/15/prefer-luadoc-to-luals-semantictokens/)
		},
		diagnostics = {
			-- NOTE: Make sure to `luacheck` is NOT installed to any paths
			enable = true,
			disable = {
				-- 'unused-function', -- avoid dimmed contents of functions (hard to read (!!))
				'empty-block',
			},
			libraryFiles = 'Disable',
		},
	},
}

---@type vim.lsp.Config
return {
	settings = settings,
}
