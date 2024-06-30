---@type LazySpec
local spec = { "folke/lazydev.nvim" }

spec.ft = { "lua" }

spec.opts = {
	library = {
		"lazy.nvim",
		{ path = "luvit-meta/library", words = { "vim%.uv" } },
	},
}

spec.dependencies = {
	"Bilal2453/luvit-meta", -- optional `vim.uv` typings
	{
		"hrsh7th/nvim-cmp",
		opts = function(_, opts)
			opts.sources = opts.sources or {}
			table.insert(opts.sources, {
				name = "lazydev",
				group_index = 0, -- set group index to 0 to skip loading LuaLS completions
			})
		end,
	},
}

return spec
