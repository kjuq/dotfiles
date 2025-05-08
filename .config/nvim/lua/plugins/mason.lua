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

spec.dependencies = {
	'neovim/nvim-lspconfig',
}

return spec
