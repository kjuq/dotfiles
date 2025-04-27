-- `MasonInstall pyright ruff bashls clangd lua-language-server markdown-oxide tinymist efm stylua luacheck uncrustify clang-format mypy shfmt`

---@type LazySpec
local spec = { 'williamboman/mason.nvim' }

spec.event = 'VeryLazy'

spec.cmd = {
	'Mason',
	'MasonInstall',
	'MasonUninstall',
	'MasonUninstallAll',
	'MasonLog',
}

spec.opts = {
	ui = {
		border = vim.o.winborder,
	},
}

spec.config = function(_, opts)
	require('mason').setup(opts)
	local exceptions = {
		lua_language_server = 'lua_ls',
	}
	local servers_to_enable = {}
	for _, v in ipairs(require('mason-registry').get_installed_packages()) do
		if vim.tbl_contains(v.spec.categories, 'LSP') then
			local server = string.gsub(v.name, '-', '_')
			server = exceptions[server] or server
			servers_to_enable[#servers_to_enable + 1] = server
		end
	end
	vim.lsp.enable(servers_to_enable)
end

spec.dependencies = {
	'neovim/nvim-lspconfig',
}

return spec
