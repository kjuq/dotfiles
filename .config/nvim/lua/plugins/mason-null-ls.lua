---@type LazySpec
local spec = { "jay-babu/mason-null-ls.nvim" }
spec.event = "LspAttach"

spec.opts = function()
	local null_ls = require("null-ls")

	return {
		handlers = {
			function() end, -- disables automatic setup of all null-ls sources
			stylua = function()
				null_ls.register(null_ls.builtins.formatting.stylua)
			end,
		},
	}
end

spec.dependencies = {
	"williamboman/mason.nvim",
	"nvimtools/none-ls.nvim",
	"nvim-lua/plenary.nvim",
}

return spec
