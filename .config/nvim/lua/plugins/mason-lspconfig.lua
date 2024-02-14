---@type LazySpec
local spec = { "williamboman/mason-lspconfig.nvim" }
spec.event = require("utils.lazy").verylazy

spec.config = function()
	require("mason-lspconfig").setup({
		ensure_installed = {
			"bashls",
			"clangd",
			"lua_ls",
			"pylsp",
		},
	})

	local lspconfig = require("lspconfig")
	local common_opts = {
		handlers = require("core.lsp").handlers,
		capabilities = pcall(require, "cmp") and require("cmp_nvim_lsp").default_capabilities() or nil,
	}

	require("mason-lspconfig").setup_handlers({

		function(server_name)
			lspconfig[server_name].setup(common_opts)
		end,

		["pylsp"] = function()
			lspconfig.pylsp.setup(vim.tbl_deep_extend("error", common_opts, require("plugins.lsp.pylsp").opts))
		end,

		["lua_ls"] = function()
			lspconfig.lua_ls.setup(vim.tbl_deep_extend("error", common_opts, require("plugins.lsp.lua_ls").opts))
		end,
	})

	-- for lazy load
	vim.bo.filetype = vim.bo.filetype
end

spec.dependencies = {
	"neovim/nvim-lspconfig",
	"williamboman/mason.nvim",
}

return spec
