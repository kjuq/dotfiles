---@module 'lazy'
---@type LazySpec
local spec = { 'https://github.com/SmiteshP/nvim-navic' }

spec.event = 'LspAttach'

spec.opts = {
	lsp = {
		auto_attach = true,
	},
}

spec.config = function(spc, opts)
	require(spc.name).setup(opts)

	local winbar_bak = vim.o.winbar
	local navic_winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"

	local enable = function()
		vim.o.winbar = navic_winbar
	end

	local disable = function()
		vim.o.winbar = winbar_bak
	end

	local toggle_winbar = function()
		if vim.o.winbar == winbar_bak then
			enable()
		else
			disable()
		end
	end

	vim.keymap.set('n', '<Space>an', toggle_winbar, { desc = 'Navic: Toggle' })
end

return spec
