---@type LazySpec
local spec = { "jay-babu/mason-null-ls.nvim" }
spec.event = "LspAttach"

spec.opts = {
	ensure_installed = {
		"autopep8",
		"shellcheck",
		"codelldb",
		"debugpy",
	},
	automatic_installation = true,
}

spec.dependencies = {
	"williamboman/mason.nvim",
	"nvimtools/none-ls.nvim",
}

return spec
