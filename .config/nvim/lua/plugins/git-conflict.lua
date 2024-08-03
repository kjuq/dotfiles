---@type LazySpec
local spec = { "akinsho/git-conflict.nvim" }

spec.version = "*"

spec.event = "VeryLazy"

spec.opts = {}

spec.config = function(_, opts)
	vim.defer_fn(function()
		vim.cmd.edit()
	end, 0)
	require("git-conflict").setup(opts)
end

return spec
