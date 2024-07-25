---@type LazySpec
local spec = { "folke/lazydev.nvim" }

spec.event = "VeryLazy"

spec.opts = {
	library = {
		"lazy.nvim",
		{ path = "luvit-meta/library", words = { "vim%.uv" } },
	},
}

spec.config = function(_, opts)
	local group = vim.api.nvim_create_augroup("user_lazyload_lazydev", {})
	vim.api.nvim_create_autocmd({ "FileType" }, {
		pattern = "lua",
		group = group,
		callback = function()
			require("lazydev").setup(opts)
		end,
		once = true,
	})
	vim.api.nvim_exec_autocmds("FileType", { pattern = vim.o.filetype })

	vim.api.nvim_create_autocmd({ "InsertEnter" }, {
		group = group,
		callback = function()
			local cmp_opts = require("plugins.cmp").opts or {} --[[@ as cmp.ConfigSchema]]
			cmp_opts.sources = cmp_opts.sources or {}
			table.insert(cmp_opts.sources, {
				name = "lazydev",
				group_index = 0, -- set group index to 0 to skip loading LuaLS completions
			})
			require("cmp").setup(cmp_opts)
		end,
		once = true,
	})
end

spec.dependencies = {
	"Bilal2453/luvit-meta", -- optional `vim.uv` typings
	-- {
	-- 	-- TODO: lazy loading cmp
	-- 	"hrsh7th/nvim-cmp",
	-- 	opts = function(_, opts)
	-- 		opts.sources = opts.sources or {}
	-- 		table.insert(opts.sources, {
	-- 			name = "lazydev",
	-- 			group_index = 0, -- set group index to 0 to skip loading LuaLS completions
	-- 		})
	-- 	end,
	-- },
}

return spec
