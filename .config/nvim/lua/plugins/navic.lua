---@type LazySpec
local spec = { 'SmiteshP/nvim-navic' }

spec.event = 'LspAttach'

spec.opts = {
	lsp = {
		auto_attach = true,
	},
}

spec.config = function(spc, opts)
	require(spc.name).setup(opts)
	vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
end

return spec
