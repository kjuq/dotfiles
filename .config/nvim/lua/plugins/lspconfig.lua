---@type LazySpec
local spec = { "neovim/nvim-lspconfig" }

spec.config = function()
	require("lspconfig.ui.windows").default_options.border = require("utils.common").floatwinborder
end

return spec
