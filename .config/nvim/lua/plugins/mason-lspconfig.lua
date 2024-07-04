---@type LazySpec
local spec = { "williamboman/mason-lspconfig.nvim" }
spec.event = require("utils.lazy").verylazy

spec.config = function()
	require("mason-lspconfig").setup()

	local lspconfig = require("lspconfig")
	local common_opts = {
		handlers = require("core.lsp").handlers,
		capabilities = pcall(require, "cmp")
				and pcall(require, "cmp_nvim_lsp")
				and require("cmp_nvim_lsp").default_capabilities()
			or nil,
	}

	require("mason-lspconfig").setup_handlers({
		function(server_name)
			local conf_path = "plugins.lsp." .. server_name
			local success, conf = pcall(require, conf_path)
			local opts = success and conf.opts or {}
			lspconfig[server_name].setup(vim.tbl_deep_extend("error", common_opts, opts))
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
