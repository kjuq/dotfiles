---@type LazySpec
local spec = {
	"williamboman/mason-lspconfig.nvim",
	event = require("utils.lazy").verylazy,
	config = function()
		require("mason-lspconfig").setup({
			ensure_installed = {
				"bashls",
				"clangd",
				"lua_ls",
				"pylsp",
			},
		})

		require("mason-lspconfig").setup_handlers({
			function(server_name)
				local lspconfig = require("lspconfig")
				local common_opts = require("plugins.lsp.common")
				lspconfig[server_name].setup(common_opts)
			end,

			["pylsp"] = require("plugins.lsp.pylsp").setup,
			["lua_ls"] = require("plugins.lsp.lua_ls").setup,
			["bashls"] = require("plugins.lsp.bashls").setup,

		})

		-- for lazy load
		vim.bo.filetype = vim.bo.filetype
	end,
	dependencies = {
		"neovim/nvim-lspconfig",
		"williamboman/mason.nvim",
	},
}

return spec
