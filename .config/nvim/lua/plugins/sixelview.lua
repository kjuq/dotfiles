---@type LazySpec
local spec = { "kjuq/sixelview.nvim" }

spec.event = "VeryLazy"

spec.opts = {}

spec.config = function(_, opts)
	require("sixelview").setup(opts)
	vim.defer_fn(function()
		vim.cmd.edit()
	end, 0)
end

return spec
